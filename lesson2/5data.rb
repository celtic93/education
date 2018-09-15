puts 'Введите число, номер месяца, год'
day = gets.to_i
month = gets.to_i
year = gets.to_i

is_leaf = year % 400 == 0 || year % 4 == 0 && year % 100 != 0

months = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
months[2] = 29 if is_leaf

date = months[0...month].sum + day

puts date
