# frozen_string_literal: true

RSpec.describe Mpf do
  it "has a version number" do
    expect(Mpf::VERSION).not_to be nil
  end

  it "requires MaximalPalindrome" do
    expect(MaximalPalindrome).not_to be nil
  end
end
