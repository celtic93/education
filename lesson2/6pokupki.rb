goods = {}

loop do  
  puts 'Введите товар, цену и количество товара. Когда закончите, введите stop'
  product = gets.chomp

  if product == 'stop'
    break
  end
  
  cost = gets.to_f
  number = gets.to_f

  records = {cost: cost, number: number}
  goods[product] = records
end

puts goods

sum_all = 0

goods.each_pair do |product, records|
  sum = records[:cost]*records[:number]
  puts "Общая сумма за #{product} равняется #{sum}"
  sum_all += sum
end

puts "Общая сумма за все товары равняется #{sum_all}"
