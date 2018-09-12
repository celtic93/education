puts 'Как Вас зовут?'
name = gets.chomp

puts 'Ваш рост?'
rost = gets.to_i

if rost - 110 > 0
	puts "#{name}, Ваш идеальный вес - #{rost - 110} кг."
else
	puts 'Ваш вес оптимальный.'
end