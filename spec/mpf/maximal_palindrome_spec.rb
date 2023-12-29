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
    # s_prime = "|a|a|b|c|"
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
    # s_prime = "|a|c|c|"
    mp.manacher(s)
    expect(mp.suffix_palindromes).to eq([[4, 2], [5, 1], [6, 0]])
  end

  it "computes mpl of 'abc'" do
    s = "abc"
    # s_prime = "|a|b|c|"
    #     index  0123456
    #     radii  0101010
    mp.manacher(s)
    mp.set_maximal_palindromic_lengths
    expect(mp.maximal_palindromic_lengths).to eq([0, 1, 0, 1, 0, 1, 0])
  end

  it "computes mpl of 'abbc'" do
    s = "abbc"
    # s_prime = "|a|b|b|c|"
    #     index  012345678
    #     radii  010121010
    mp.manacher(s)
    mp.set_maximal_palindromic_lengths
    expect(mp.maximal_palindromic_lengths).to eq([0, 1, 0, 1, 4, 1, 0, 1, 0])
  end

  it "computes mpl of 'abbbc'" do
    s = "abbbc"
    # s_prime = "|a|b|b|b|c|"
    #     index  012345678910
    #     radii  01012321010
    mp.manacher(s)
    mp.set_maximal_palindromic_lengths
    expect(mp.maximal_palindromic_lengths).to eq([0, 1, 0, 1, 4, 5, 4, 1, 0, 1, 0])
  end

  # it "computes only the longest palindromes" do
  #   s = "acc"
  #   mp.manacher(s)
  #   # s_prime = "|a|c|c|"
  #   #     index  0123456
  #   #     radii  0101210
  #   expect(mp.remove_redundant_values).to eq([[1, 1], [4, 2]])
  # end

  # it "computes another example of longest palindromes" do
  #   s = "aabc"
  #   # s_prime = "|a|a|b|c|"
  #   #     index  012345678
  #   #     radii  012101010
  #   mp.manacher(s)
  #   expect(mp.remove_redundant_values).to eq([[2, 2], [5, 1], [7, 1]])
  # end

  # it "computes 'aba' non-redundant values correctly" do
  #   s = "aba"
  #   # s_prime = "|a|b|a|"
  #   #     index  0123456
  #   #     radii  0103010
  #   mp.manacher(s)
  #   expect(mp.remove_redundant_values).to eq([[3, 3]])
  # end

  it "sets mp correctly" do
    s = "abc"
    # s_prime = "|a|b|c|"
    #     index  0123456
    #     radii  0101010
    # cleaned_up = [[1, 1], [3, 1], [5, 1]]
    mp.manacher(s)
    mp.set_mp
    expect(mp.mp).to eq([[0, 1], [1, 1], [2, 1]])
  end

  it "sets mp correctly for odd input with odd pal" do
    s = "aba"
    mp.manacher(s)
    mp.set_mp
    expect(mp.mp).to eq([[1, 3]])
  end

  it "computes center correctly" do
    # s_prime = "|a|b|c|"
    #     index  0123456
    #     radii  0101010
    # center(0) = 0
    # center(1) = 0
    # center(2) = 1
    # center(3) = 1
    # center(4) = 2
    # center(5) = 2
    # center(6) = 3
    expect(mp.center(0)).to eq(0)
    expect(mp.center(1)).to eq(0)
    expect(mp.center(2)).to eq(1)
    expect(mp.center(3)).to eq(1)
    expect(mp.center(4)).to eq(2)
    expect(mp.center(5)).to eq(2)
    expect(mp.center(6)).to eq(3)
  end
end
