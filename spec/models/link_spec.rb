require 'rails_helper'

RSpec.describe Link, type: :model do
  it "creates correct first item url" do
    Link.create!(origin: "http://example.com")

    expect(Link.first.url).to eq(URL_CHARS[0])
  end

  it "creates correct second item url" do
    Link.create!(origin: "http://example.com")

    Link.create!(origin: "http://example.com/2")

    expect(Link.last.url).to eq(URL_CHARS[1])
  end

  it "extends url length if necessary" do
    first = Link.create!(origin: "http://example.com")
    first[:url] = URL_CHARS[-1]
    first.save

    Link.create!(origin: "http://example.com/2")

    expect(Link.last.url).to eq(URL_CHARS[0]*2)
  end
end
