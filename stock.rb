def stock_picker(arr)
  # find all possible profits(or losses)
  # in the end we'll have hash with items in such format: buy_index $ sell_index => profit
  profits = {}
  arr.each_with_index do |buy_v, buy_i|
    arr.each_with_index do |sell_v, sell_i|
      profits["#{buy_i}$#{sell_i}"] = sell_v - buy_v unless buy_i > sell_i
    end
  end

  # find best value(profit) and key(days)
  bst_profit = 0
  bst_days = ''
  profits.each do |days, profit|
    if bst_profit < profit
      bst_profit = profit
      bst_days = days
    end
  end

  # finally return keys(days), when to buy and sell, in array
  bst_days.split('$')
end

p stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10])
