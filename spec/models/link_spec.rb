require 'rails_helper'

RSpec.describe Link, type: :model do
  it "fixes origin url scheme" do
    Link.create!(origin: "example.com")

    expect(Link.last.origin).to eq("http://example.com")
  end

  it "creates correct first item url" do
    Link.create!(origin: "http://example.com")

    expect(Link.first.url).to eq(ALLOWED_URL_CHARS[0])
  end

  it "creates correct second item url" do
    Link.create!(origin: "http://example.com")

    Link.create!(origin: "http://example.com/2")

    expect(Link.last.url).to eq(ALLOWED_URL_CHARS[1])
  end

  it "extends url length if necessary" do
    first = Link.create!(origin: "http://example.com")
    first[:url] = ALLOWED_URL_CHARS[-1]
    first.save

    Link.create!(origin: "http://example.com/2")

    expect(Link.last.url).to eq(ALLOWED_URL_CHARS[0]*2)
  end

  it "turns counter" do
    link = Link.create!(origin: "http://example.com")

    link.turn_counter

    expect(link.counter).to eq(1)
  end
end
