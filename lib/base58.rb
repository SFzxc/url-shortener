# Base58
# Copyright (c) 2009 - 2018 Douglas F Shearer.
# http://douglasfshearer.com
# Distributed under the MIT license as included with this plugin.
#
# Update a new customize alphabets by @longhoang
class Base58
  ALPHABETS = {
    shorten: 'ABCDEFGHJKMNPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz123456789'
  }.freeze

  # NOTE: If adding new alphabets of non-standard length, this should become a method.
  BASE = ALPHABETS[:shorten].length

  # Converts a base58 string to a base10 integer.
  def self.base58_to_int(base58_val, alphabet = :shorten)
    raise ArgumentError, 'Invalid alphabet selection.' unless ALPHABETS.include?(alphabet)

    int_val = 0
    base58_val.reverse.split(//).each_with_index do |char, index|
      if (char_index = ALPHABETS[alphabet].index(char)).nil?
        raise ArgumentError, 'Value passed not a valid Base58 String.'
      end

      int_val += char_index * (BASE**index)
    end
    int_val
  end

  # Converts a base10 integer to a base58 string.
  def self.int_to_base58(int_val, alphabet = :shorten)
    raise ArgumentError, 'Value passed is not an Integer.' unless int_val.is_a?(Integer)
    raise ArgumentError, 'Invalid alphabet selection.' unless ALPHABETS.include?(alphabet)

    base58_val = ''
    while int_val >= BASE
      mod = int_val % BASE
      base58_val = ALPHABETS[alphabet][mod, 1] + base58_val
      int_val = (int_val - mod) / BASE
    end
    ALPHABETS[alphabet][int_val, 1] + base58_val
  end

  class << self
    alias encode int_to_base58
    alias decode base58_to_int
  end
end
