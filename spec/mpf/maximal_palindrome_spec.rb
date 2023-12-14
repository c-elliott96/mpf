# frozen_string_literal: true

# maximal_palindrome_spec.rb
RSpec.describe MaximalPalindrome do
  let(:mp) { MaximalPalindrome.new }
  it "raises ArgumentError on nil input" do
    expect { mp.manacher(nil) }.to raise_error(ArgumentError, "Input must be string-like")
  end

  it "raises ArgumentError on non-string input" do
    expect { mp.manacher([]) }.to raise_error(ArgumentError, "Input must be string-like")
  end

  it "computes valid odd-length input" do
    s = "abc"
    # s_prime = "|a|b|c|"
    mp.manacher(s)
    expect(mp.maximal_palindromes).to eq([0, 1, 0, 1, 0, 1, 0])
  end

  it "computes valid even-length input" do
    s = "ab"
    # s_prime = "|a|b|"
    mp.manacher(s)
    expect(mp.maximal_palindromes).to eq([0, 1, 0, 1, 0])
  end

  it "computes odd-length string with an odd-length palindrome" do
    s = "abbbc"
    # s_prime = "|a|b|b|b|c|"
    mp.manacher(s)
    expect(mp.maximal_palindromes).to eq([0, 1, 0, 1, 2, 3, 2, 1, 0, 1, 0])
  end

  it "computes even-length string with an even-length palindrome" do
    s = "abbc"
    # s_prime = "|a|b|b|c|"
    mp.manacher(s)
    expect(mp.maximal_palindromes).to eq([0, 1, 0, 1, 2, 1, 0, 1, 0])
  end

  it "computes odd-length string with an even-length palindrome" do
    s = "abbbb"
    # s_prime = "|a|b|b|b|b|"
    mp.manacher(s)
    expect(mp.maximal_palindromes).to eq([0, 1, 0, 1, 2, 3, 4, 3, 2, 1, 0])
  end

  it "computes even-length string with an odd-length palindrome" do
    s = "abbb"
    # s_prime = "|a|b|b|b|"
    #   expect   010123210
    mp.manacher(s)
    expect(mp.maximal_palindromes).to eq([0, 1, 0, 1, 2, 3, 2, 1, 0])
  end

  it "computes odd-length prefix_palindromes" do
    s = "abc"
    mp.manacher(s)
    expect(mp.prefix_palindromes).to eq([[0, 0], [1, 1]])
  end

  it "computes even-length prefix_palindromes" do
    s = "aabc"
    # s_prime = "|a|a|b|c"
    mp.manacher(s)
    expect(mp.prefix_palindromes).to eq([[0, 0], [1, 1], [2, 2]])
  end

  it "computes odd-length suffix_palindromes" do
    s = "abc"
    # s_prime = "|a|b|c|"
    mp.manacher(s)
    expect(mp.suffix_palindromes).to eq([[5, 1], [6, 0]])
  end

  it "computes even-length suffix_palindromes" do
    s = "acc"
    # s_prime = "|a|b|b|"
    mp.manacher(s)
    expect(mp.suffix_palindromes).to eq([[4, 2], [5, 1], [6, 0]])
  end
end
