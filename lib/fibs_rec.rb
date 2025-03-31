# frozen_string_literal: true

# ____________Psudocode______________
# handle 0 and 1
#
# check if previous fibonacci number exist
#   find it recursively if not
#
# calculate fibunacci for curren iteration
#
# check if array size match sequence size
#   return array if true
#   else return current fibonacci number
# -----------------------------------

# find fibonacci sequence using reqursion
def fib(num, target_size = num + 1, arr = [0, 1])
  # target_size set to num + 1 because sequence of
  # fibonacci numbers of index n contains n + 1 items.

  return num if num <= 1

  arr[num - 1] = fib(num - 1, target_size, arr) if arr[num - 1].nil?

  arr[num] = arr[num - 1] + arr[num - 2]
  return arr if arr.size == target_size

  arr[num]
end

p fib(5)
p fib(12)
