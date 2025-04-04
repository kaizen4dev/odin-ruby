# frozen_string_literal: true

require_relative 'bucket'

# my hashmap implementation
class HashMap
  attr_reader :load_factor, :capacity, :array

  def initialize
    self.capacity = 16
    self.load_factor = 0.8
    self.array = Array.new(16) { Bucket.new }
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def set(key, value)
    array[hash(key) % capacity].set(key, value)
  end

  def get(key)
    found = nil

    array.each do |bucket|
      found = bucket.get(key)
      break unless found.nil?
    end

    found
  end

  def has?(key)
    !get(key).nil?
  end

  def remove(key)
    array[hash(key) % capacity].remove(key)
  end

  def length
    array.map(&:size).sum
  end

  private

  attr_writer :load_factor, :capacity, :array
end
