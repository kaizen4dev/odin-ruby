# frozen_string_literal:true

require_relative 'lib/hash_map'

test = HashMap.new

test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')

p test.get('lion')

test.remove('lion')

p test.get('lion')

p test.length

p test.keys
p test.values
p test.entries

1000.times do |i|
  test.set(i.to_s, rand(2000))
end

p test.array.map(&:size)
