# frozen_string_literal: true

require_relative 'bucket'

# my hashmap implementation
class HashMap
  attr_reader :load_factor, :capacity, :array

  def initialize
    self.capacity = 16
    self.load_factor = 0.8
    self.array = Array.new(16, Bucket.new)
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  private

  attr_writer :load_factor, :capacity, :array
end
