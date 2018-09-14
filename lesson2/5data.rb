puts 'Введите число, номер месяца, год'
day = gets.to_i
month = gets.to_i
year = gets.to_i

if year % 400 == 0
  puts 'Высокосный'
  n = 1
elsif year % 100 == 0
  puts 'Невысокосный'
  n = 0
elsif year % 4 == 0  
  puts 'Высокосный'
  n = 1
else
  puts 'Невысокосный'
  n = 0
end

months = {
  1 => 31,
  2 => 28+n,
  3 => 31,
  4 => 30,
  5 => 31,
  6 => 30,
  7 => 31,
  8 => 31,
  9 => 30,
  10 => 31,
  11 => 30,
  12 => 31
}

(1..month-1).each do |days|
  day += months[days]
end

puts day
