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

  def delete(value, node = root) # rubocop:disable Metrics
    # base case
    return if node.nil?

    # compare value with current node's value
    case value <=> node.value
    when 1
      # if value is more than current node's move to the right
      node.right = delete(value, node.right)
    when -1
      # if value is less than current node's move to the left
      node.left = delete(value, node.left)
    when 0 # when values are equal
      # if one/none of nodes is present
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      # if both nodes are present

      # find replacement for deleted node
      replacement = node.right
      replacement = replacement.left until replacement.left.nil?

      # assign replacement value to node and delete replacement node
      node.value = replacement.value
      node.right = delete(replacement.value, node.right)
    end

    # return node after everything is done.
    node
  end

  def find(value, node = root)
    return if node.nil?
    return node if node.value == value

    next_node = node.value > value ? node.left : node.right
    find(value, next_node)
  end

  def level_order(node = root, &block)
    return if node.nil?

    queue = [node]
    levels = []

    until queue.empty?
      levels.push queue.map(&:value)
      queue.each(&block)
      queue = queue.map { |node| [node.left, node.right] }.flatten.compact
    end

    levels unless block_given?
  end

  def preorder(node = root, values = [], &block)
    return if node.nil?

    values.push node.value
    yield node if block_given?

    preorder(node.left, values, &block)
    preorder(node.right, values, &block)

    values unless block_given?
  end

  def inorder(node = root, values = [], &block)
    return if node.nil?

    inorder(node.left, values, &block)

    values.push node.value
    yield node if block_given?

    inorder(node.right, values, &block)

    values unless block_given?
  end

  def postorder(node = root, values = [], &block)
    return if node.nil?

    postorder(node.left, values, &block)
    postorder(node.right, values, &block)

    values.push node.value
    yield node if block_given?

    values unless block_given?
  end

  def depth(value, node = root, depth = 0)
    return if node.nil?
    return depth if node.value == value

    next_node = node.value > value ? node.left : node.right
    depth(value, next_node, depth + 1)
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
