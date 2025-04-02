# frozen_string_literal: true

require_relative 'node'

# list of nodes, where each node holds certain value and points at next node
class LinkedList
  attr_reader :head_node, :tail_node, :size

  private

  attr_writer :head_node, :tail_node, :size
end
