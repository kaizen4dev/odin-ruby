# returns sorted array(from smallest to biggest number)
def bubble_sort(array)
  prev_array = []
  count = array.size

  until array == prev_array
    prev_array = array.dup
    array = bubble(array, count)
    count -= 1
  end

  array
end

# single iteration of bubble sort, where num is
# number of elements in array to compare, since
# rest may be already sorted.
def bubble(array, num = array.size)
  num -= 1 # subtracting one since change affect array[num + 1]
  i = 0
  num.times do
    value = array[i]
    if array[i + 1] < value
      array[i] = array[i + 1]
      array[i + 1] = value
    end
    i += 1
  end
  array
end

p bubble_sort([4, 3, 78, 2, 0, 2])
