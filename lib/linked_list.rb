# frozen_string_literal: true

require_relative 'node'

# list of nodes, where each node holds certain value and points at next node
class LinkedList
  # read head_node, tail_node and size
  attr_reader :head_node, :tail_node, :size

  def initialize
    self.size = 0
  end

  # add value to the beginning of the Linked List
  def prepend(value)
    self.head_node = Node.new(value, head_node)
    self.size += 1

    self.tail_node = head_node if tail_node.nil?
  end

  # add value to the end of Linked List
  def append(value)
    return prepend(value) if head_node.nil?

    new_node = Node.new(value)
    tail_node.next = new_node
    self.tail_node = new_node
    self.size += 1
  end

  # get value of head node
  def head
    head_node.value
  end

  # get value of tail node(should be nil)
  def tail
    tail_node.value
  end

  # get node at provided index
  def node_at(index)
    current = head_node

    index.times do
      current = current.next
    end

    current
  end

  # get value of node at provided index
  def at(index)
    node_at(index).value
  end

  # remove/pop last element
  def pop
    self.size -= 1
    removed = tail_node

    self.tail_node = node_at(size - 1)
    tail_node.next = nil

    removed.value
  end

  # check if Linked List contains value
  def contains?(value)
    current = head_node
    current = current.next until current.value == value || current == tail_node
    current.value == value
  end

  # find index of an value, returns nil if not found
  def find(value)
    current = head_node
    index = 0

    loop do
      return nil if current.nil?
      return index if current.value == value

      current = current.next
      index += 1
    end
  end

  # convert Linked List to string
  def to_s
    string = ''
    current = head_node

    until current.nil?
      string += "( #{current.value} ) -> "
      current = current.next
    end

    string << 'nil'
  end

  # place value(node) at provided index
  def insert_at(value, index)
    prv = node_at(index - 1)
    prv.next = Node.new(value, prv.next)
    self.size += 1
  end

  # remove node at provided index
  def remove_at(index)
    self.size -= 1
    prv = node_at(index - 1)
    removed = prv.next
    prv.next = removed.next
    removed.value
  end

  private

  attr_writer :head_node, :tail_node, :size
end
