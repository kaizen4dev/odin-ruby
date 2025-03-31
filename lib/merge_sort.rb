# frozen_string_literal: true

def merge_sort(arr) # rubocop:disable Metrics/AbcSize
  # base case
  return arr if arr.size == 1

  # split
  mid = (arr.size / 2.0).ceil
  part1 = merge_sort(arr[...mid])
  part2 = merge_sort(arr[mid...])

  # sort by shifting least value till one of parts is empty
  sorted = []
  until part1.empty? || part2.empty?
    least = part1[0] > part2[0] ? part2.shift : part1.shift
    sorted.push least
  end

  # non empty part will be already sorted, so we can just
  # join it and return
  sorted + part1 + part2
end

p merge_sort([3, 2, 1, 13, 8, 5, 0, 1])
p merge_sort([105, 79, 100, 110])
