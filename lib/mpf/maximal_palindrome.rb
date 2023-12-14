# frozen_string_literal: true
# lib/maximal_palindrome.rb

# rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity
# rubocop:disable Metrics/MethodLength, Metrics/PerceivedComplexity

# Defines instance method to find MP(s) of an input string by applying
# Manacher's Algorithm
# TODO Move manacher's algorithm into the initializer
class MaximalPalindrome
  def initialize
    @maximal_palindromes = []
    @prefix_palindromes = []
    @suffix_palindromes = []
  end

  def maximal_palindromes
    @maximal_palindromes
  end

  def prefix_palindromes
    @prefix_palindromes
  end

  def suffix_palindromes
    @suffix_palindromes
  end

  def manacher(string)
    # This method takes in a string and computes the set radii of all
    # palindromes of the string. We store this set as MP(s). We also
    # simultaneously compute the prefix and suffix palindromes of MP(s).
    #
    #From
    # https://en.wikipedia.org/wiki/Longest_palindromic_substring#Manacher's_algorithm

    # Make sure input is valid string
    raise ArgumentError, "Input must be string-like" unless string.respond_to?(:chars)

    # s' = s with a bogus character ('|') inserted between each character
    # (including outer boundaries)
    s_prime = "|#{string.chars.join("|")}|"
    # The radius of the longest palindrome centered on each index of S'
    # Note: s'.length = radii.length = s.length * 2 + 1
    radii = [0] * s_prime.length
    center = 0
    radius = 0

    while center < s_prime.length
      # Determine the longest palindrome from center-radius to center+radius
      while center - (radius + 1) >= 0 &&
            center + (radius + 1) < s_prime.length &&
            s_prime[center - (radius + 1)] == s_prime[center + (radius + 1)]
        radius += 1
      end
      # Store the radius
      radii[center] = radius
      # Center is incremented, and if we can reuse some values, we do
      prev_center = center
      prev_radius = radius
      center += 1
      # Reset radius
      radius = 0
      while center <= prev_center + prev_radius
        # Because center lies inside the old palindrome and every character
        # inside a palindrome has a mirrored char opposite its center, we can
        # use the data that was previously computed for the center's mirrored
        # point
        mirrored_center = prev_center - (center - prev_center)
        max_mirrored_radius = prev_center + prev_radius - center
        # There are three cases in which we find ourselves in this situation.
        # They're explained below.
        if radii[mirrored_center] < max_mirrored_radius
          # The palindrome centered at mirrored_center is entirely contained
          # in the palindrome at prev_center, so, mirrored_center and center
          # have the same sized palindrome
          radii[center] = radii[mirrored_center]
          center += 1
        elsif radii[mirrored_center] > max_mirrored_radius
          # The palindrome at mirrored_center extends beyond the palindrome at
          # prev_center, so the palindrome at center must end at the edge of
          # the prev_center palindrome. Otherwise, the paldinrome at
          # prev_center would be bigger.
          radii[center] = max_mirrored_radius
          center += 1
        else
          # The palindrome at mirrored_center ends precisely at the edge of
          # the palindrome centered at prev_center. Therefore, the palindrome
          # at center might be bigger. Set radius to the minimum size of the
          # palindrome at center so it doesn't recheck unnecessarily.
          radius = max_mirrored_radius
          break
        end
      end
    end

    # Calculate prefix_pals and suffix_pals
    # for each radius, add to prefix_palindromes if
    # center - radius = 0
    # and add to suffix_palindromes if
    # center + radius = s_prime.len - 1
    radii.each_with_index do |radius, center|
      @prefix_palindromes.append([center, radius]) unless center - radius != 0
      @suffix_palindromes.append([center, radius]) unless center + radius != s_prime.length - 1
    end

    # For now, set @maximal_palindromes to radii and just return radii
    # so tests pass. ... Update tests later.
    @maximal_palindromes = radii
    radii
  end
end

# rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity
# rubocop:enable Metrics/MethodLength, Metrics/PerceivedComplexity
