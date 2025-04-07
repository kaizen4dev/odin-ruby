# frozen_string_literal: true

# node for binary tree
class Node
  include Comparable
  attr_accessor :value, :left, :right

  def initialize(value, left = nil, right = nil)
    self.value = value
    self.left = left
    self.right = right
  end

  def <=>(other)
    value <=> other.value
  end
end
