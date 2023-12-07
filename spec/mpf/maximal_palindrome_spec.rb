# frozen_string_literal: true

# maximal_palindrome_spec.rb
RSpec.describe MaximalPalindrome do
  it "raises ArgumentError on nil input" do
    expect { MaximalPalindrome.manacher(nil) }.to raise_error(ArgumentError, "Input cannot be nil")
  end

  it "computes valid odd-length input" do
    s = "abc"
    expect(MaximalPalindrome.manacher(s)).to eq([0, 1, 0, 1, 0, 1, 0])
  end

  it "computes valid even-length input" do
    s = "ab"
    # s_prime = "|a|b|"
    expect(MaximalPalindrome.manacher(s)).to eq([0, 1, 0, 1, 0])
  end

  it "computes odd-length string with an odd-length palindrome" do
    s = "abbbc"
    # s_prime = "|a|b|b|b|c|"
    expect(MaximalPalindrome.manacher(s)).to eq([0, 1, 0, 1, 2, 3, 2, 1, 0, 1, 0])
  end

  it "computes even-length string with an even-length palindrome" do
    s = "abbc"
    # s_prime = "|a|b|b|c|"
    expect(MaximalPalindrome.manacher(s)).to eq([0, 1, 0, 1, 2, 1, 0, 1, 0])
  end

  it "computes odd-length string with an even-length palindrome" do
    s = "abbbb"
    # s_prime = "|a|b|b|b|b|"
    expect(MaximalPalindrome.manacher(s)).to eq([0, 1, 0, 1, 2, 3, 4, 3, 2, 1, 0])
  end
end
