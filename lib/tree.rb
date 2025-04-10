# frozen_string_literal: true

require_relative 'node'

# binary search tree
class Tree
  attr_reader :root

  def initialize(array)
    array = array.uniq.sort
    self.root = build_tree(array)
  end

  # taken from Binary Search Trees lesson, my regards to whoever built that method.
  def pretty_print(node = @root, prefix = '', is_left = true) # rubocop:disable Style/OptionalBooleanParameter
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value, node = root)
    # find leaf node and which side to use for insertion
    left = nil
    loop do
      return node if value == node.value

      left = value < node.value
      next_node = left ? node.left : node.right
      break if next_node.nil?

      node = next_node
    end

    # insert new node
    new = Node.new(value)
    left ? node.left = new : node.right = new
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
