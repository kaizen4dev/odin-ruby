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
    self.size += 1
  end

  def head
    head_node.value
  end

  def tail
    tail_node.value
  end

  def node_at(index)
    current = head_node

    index.times do
      current = current.next
    end

    current
  end

  def at(index)
    node_at(index).value
  end

  def pop
    self.size -= 1
    removed = tail_node

    self.tail_node = node_at(size - 1)
    tail_node.next = nil

    removed.value
  end

  def contains?(value)
    current = head_node
    current = current.next until current.value == value || current == tail_node
    current.value == value
  end

  private

  attr_writer :head_node, :tail_node, :size
end
