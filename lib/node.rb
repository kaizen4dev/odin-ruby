# frozen_string_literal: true

# single node, used in linked list
class Node
  attr_accessor :key, :value, :next

  def initialize(key, value = nil, next_node = nil)
    self.key = key
    self.value = value
    self.next = next_node
  end
end
