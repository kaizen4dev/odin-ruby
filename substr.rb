# returns hash with words(as keys) from dict(array) that 
# appear in string and count(as values).
def substr(str, dict)
  arr = str.split
  arr.reduce(Hash.new(0)) do |memo, operand|
    dict.each do |word| 
      memo[word] += 1 if operand.downcase.include?(word)
    end
    memo
  end
end


dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

puts substr("below", dictionary)
puts substr("Howdy partner, sit down! How's it going?", dictionary)
puts substr("Below", dictionary)
