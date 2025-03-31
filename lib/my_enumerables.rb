# frozen_string_literal: true

# my implementation of enumerable methods
module Enumerable
  # Your code goes here
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
