require 'rails_helper'

RSpec.describe Link, type: :model do

  before do
    Link.create!(origin: "example.com")
  end

  context "first item" do

    it "creates correct first item url" do
      expect(Link.first.url).to eq(ALLOWED_URL_CHARS[0])
    end

    it "fixes origin url scheme" do
      expect(Link.last.origin).to eq("http://example.com")
    end

    it "turns counter" do
      first = Link.first
      first.turn_counter

      expect(first.counter).to eq(1)
    end
  end

  context "second item" do

    it "creates correct second item url" do
      Link.create!(origin: "example.com/2")

      expect(Link.last.url).to eq(ALLOWED_URL_CHARS[1])
    end

    it "extends url length if necessary and reset to first char" do
      first = Link.first
      first[:url] = ALLOWED_URL_CHARS[-1]
      first.save

      second = Link.create!(origin: "example.com/2")

      expect(second.url).to eq(ALLOWED_URL_CHARS[0]*2)
    end
  end
end
