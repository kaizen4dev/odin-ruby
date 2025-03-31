# frozen_string_literal: true

# my implementation of enumerable methods
module Enumerable
  # Your code goes here
  def my_each_with_index
    count = 0
    my_each do |item|
      yield(item, count)
      count += 1
    end
  end

  def my_select
    new = []
    my_each { |item| new.push item if yield(item) }
    new
  end

  def my_all?
    my_each { |item| return false unless yield(item) }
    true
  end

  def my_any?
    my_each { |item| return true if yield(item) }
    false
  end

  def my_none?(&block)
    my_any?(&block) ? false : true
  end

  def my_count
    return size unless block_given?

    count = 0
    my_each { |item| count += 1 if yield(item) }
    count
  end

  def my_map
    new = []
    my_each { |item| new.push(yield(item)) }
    new
  end

  def my_inject(arg)
    memo = arg
    my_each { |item| memo = yield(memo, item) }
    memo
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    for item in self # rubocop:disable Style/for
      yield(item)
    end
  end
end
