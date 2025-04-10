# frozen_string_literal: true

require_relative 'node'

# binary search tree
class Tree
  attr_reader :root

  def initialize(array)
    array = array.uniq.sort
    self.root = build_tree(array)
  end

  private

  attr_writer :root

  def build_tree(array)
    # apperently, when we try  to access rest of array starting at first undefined value, it returns
    # empty array, but when we start from any other position it returns nil.. therefore 2 checks.
    return nil if array.nil? || array.empty?

    mid = (array.size / 2)
    Node.new(array[mid], build_tree(array[...mid]), build_tree(array[mid + 1...]))
  end
end
