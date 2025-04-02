# frozen_string_literal: true

# single node, used in linked list
class Node
  attr_accessor :value, :next

  def initialize(value = nil, next_node = nil)
    self.value = value
    self.next = next_node
  end
end
