pokupki = {}

loop do  
  puts 'Введите товар, цену и количество товара. Когда закончите, введите stop'
  tovar = gets.chomp

  if tovar == 'stop'
    break
  end

  cost_colvo = {}
  cost = gets.to_f
  kolvo = gets.to_f

  cost_colvo[cost] = kolvo
  pokupki[tovar] = cost_colvo
end

puts pokupki

sum_all = 0

pokupki.each_pair do |tovar2, cost_colvo2|
  sum = cost_colvo2.to_a[0][0]*cost_colvo2.to_a[0][1]
  puts "Общая сумма за #{tovar2} равняется #{sum}"
  sum_all += sum
end

puts "Общая сумма за все товары равняется #{sum_all}"
