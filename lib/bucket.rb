# frozen_string_literal: true

require_relative 'node'

# list of nodes, where each node holds certain value and points at next node
class Bucket
  # read head_node, tail_node and size
  attr_reader :head_node, :tail_node, :size

  def initialize
    self.size = 0
  end

  # add value to the end of Linked List
  def set(key, value)
    new_node = Node.new(key, value)
    tail_node.next = new_node
    self.tail_node = new_node
    self.size += 1

    self.head_node = tail_node if head_node.nil?
  end

  # get value of entry with provided key
  def get(key)
    current = head_node

    until current.nil?
      return current.value if current.key == key

      current = current.next
    end
  end

  # check if bucket contains node with provided value
  def value?(value)
    current = head_node
    current = current.next until current.value == value || current == tail_node
    current.value == value
  end

  # check if bucket contains node with provided key
  def key?(key)
    current = head_node
    current = current.next until current.key == key || current == tail_node
    current.key == key
  end

  # find key of an value, returns nil if not found
  def find(value)
    current = head_node

    loop do
      return nil if current.nil?
      return current.key if current.value == value

      current = current.next
    end
  end

  private

  attr_writer :head_node, :tail_node, :size
end
