# frozen_string_literal: true

# binary search tree
class Tree
  attr_reader :root

  def initialize(array)
    self.root = build_tree(array)
  end

  private

  attr_writer :root
end
