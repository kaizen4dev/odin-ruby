# frozen_string_literal: true

def fib(num, seq = [0, 1])
  return [0] if num.zero?

  seq.push seq[-1] + seq[-2] until seq.size == num + 1
  seq
end

p fib(5)
p fib(12)
