# frozen_string_literal: true

require_relative 'linked_list'

# my hashmap implementation
class HashMap
  attr_reader :load_factor, :capacity, :array

  def initialize
    self.capacity = 16
    self.load_factor = 0.8
    self.array = Array.new(16, LinkedList.new)
  end

  private

  attr_writer :load_factor, :capacity, :array
end
