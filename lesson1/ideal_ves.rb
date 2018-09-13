puts 'Как Вас зовут?'
name = gets.chomp

puts 'Ваш рост?'
rost = gets.to_i

ideal = rost - 110

if ideal > 0
	puts "#{name}, Ваш идеальный вес - #{ideal} кг."
else
	puts 'Ваш вес оптимальный.'
end
