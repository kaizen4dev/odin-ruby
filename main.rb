# frozen_string_literal: true

require_relative 'lib/node'
require_relative 'lib/tree'

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

puts 'Created tree:'
tree.pretty_print

puts "\nTree after '1234' inserted:"
tree.insert(1234)
tree.pretty_print

puts "\nTree after '8' deleted:"
tree.delete(8)
tree.pretty_print

puts "\nFind node/subtree with value of 67"
puts '#find output:'
found_node = p tree.find(67)
puts 'Tree of found node:'
tree.pretty_print(found_node)

puts "\n#level_order"
puts 'output without block:'
p tree.level_order
puts 'Print value of each node by using block:'
tree.level_order { |node| puts node.value }
puts 'Tree:'
tree.pretty_print

puts "\n#preorder"
puts 'output without block:'
p tree.preorder
puts 'Print value of each node by using block:'
tree.preorder { |node| puts node.value }
puts 'Tree:'
tree.pretty_print

puts "\n#inorder"
puts 'output without block:'
p tree.inorder
puts 'Print value of each node by using block:'
tree.inorder { |node| puts node.value }
puts 'Tree:'
tree.pretty_print

puts "\n#postorder"
puts 'output without block:'
p tree.postorder
puts 'Print value of each node by using block:'
tree.postorder { |node| puts node.value }
puts 'Tree:'
tree.pretty_print

puts "\n#depth"
puts "depth of 67: #{tree.depth(67)}"
puts "depth of 1: #{tree.depth(1)}"
puts "depth of 9: #{tree.depth(9)}"
puts "depth of 999: #{tree.depth(999)}"
puts 'Tree:'
tree.pretty_print

puts "\n#height"
puts "height of 67: #{tree.height(67)}"
puts "height of 1: #{tree.height(1)}"
puts "height of 9: #{tree.height(9)}"
puts "height of 999: #{tree.height(999)}"
puts 'Tree:'
tree.pretty_print

puts "\n#rebalance"
puts 'unbalanced tree:'
tree.insert(1233)
tree.insert(1235)
tree.insert(1236)
tree.pretty_print
puts '#rebalance subtree with root value of 324:'
tree.rebalance(tree.find(324))
tree.pretty_print
puts '#rebalance whole tree:'
tree.rebalance
tree.pretty_print

puts "\n#balanced?"
puts 'balanced tree:'
tree.pretty_print
puts "#balanced? output: #{tree.balanced?}"
puts 'unbalanced tree:'
tree.insert(325)
tree.insert(326)
tree.pretty_print
puts "#balanced? output: #{tree.balanced?}"
