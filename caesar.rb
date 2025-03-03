# shifts single char by provided number according to 
# English alphabet. returns original char if not alphabetical.
def shift_char(char, num)
  return char unless is_alpha?(char)

  upper = char == char.upcase
  char.downcase! if upper

  new_char = (char.ord + num).chr
  new_char = (new_char.ord - 26).chr unless is_alpha?(new_char)

  upper ? new_char.upcase : new_char
end

# encrypt string using Caesar cipher
def encrypt(str, num)
  arr = str.split("")
  arr.map! { |char| shift_char(char, reduce(num)) }
  arr.join("")
end

# decrypt string
def decrypt(str, num)
  num = reduce(num)
  encrypt(str, 26 - num)
end

# check if char contains letter
def is_alpha?(char)
  char.downcase.between?("a", "z")
end

# reduce number, so it's won't go beyond scope of alphabet..
def reduce(num)
  num = num - 26 until num <= 26
  num
end
