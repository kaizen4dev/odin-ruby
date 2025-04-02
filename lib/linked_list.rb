# frozen_string_literal: true

require_relative 'node'

# list of nodes, where each node holds certain value and points at next node
class LinkedList
  attr_reader :head_node, :tail_node, :size

  def initialize
    self.size = 0
  end

  def prepend(value)
    self.head_node = Node.new(value, head_node)
    self.size += 1

    self.tail_node = head_node if tail_node.nil?
  end

  def append(value)
    return prepend(value) if head_node.nil?

    new_node = Node.new(value)
    tail_node.next = new_node
    self.tail_node = new_node
  end

  private

  attr_writer :head_node, :tail_node, :size
end
