class Link < ActiveRecord::Base
  before_create :fix_origin_scheme, :generate_url

  def fix_origin_scheme
    origin = URI.parse(self.origin)

    unless ALLOWED_URL_SCHEMES.include? origin.scheme
      self.origin = "http://#{self.origin}"
    end

    self
  end

  def generate_url
    last_link = Link.last
    if last_link
      self.url = rotate_char(last_link.url, -1)
      self
    else
      self.url = ALLOWED_URL_CHARS[0]
      self
    end
  end

  def rotate_char(url, index)
    current_char_index = ALLOWED_URL_CHARS.index(url[index])

    if current_char_index < (ALLOWED_URL_CHARS.size - 1)
      url[index] = ALLOWED_URL_CHARS[current_char_index + 1]
      url
    else
      if index.abs == url.size
        ALLOWED_URL_CHARS[0] * index.abs + ALLOWED_URL_CHARS[0]
      else
        url[index] = ALLOWED_URL_CHARS[0]
        rotate_char(url, index - 1)
      end
    end
  end

  def turn_counter
    self.counter += 1
    self.save
  end
end
