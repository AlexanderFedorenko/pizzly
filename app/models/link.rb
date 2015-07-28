class Link < ActiveRecord::Base
  before_create :generate_url

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
end
