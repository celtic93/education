puts 'Введите a, b, c'
a = gets.to_i
b = gets.to_i
c = gets.to_i

d = b**2 - 4*a*c

if d > 0
	puts "дискриминант #{d}, корень1 #{(-b + Math.sqrt(d))/(2*a)}, корень2 #{(-b - Math.sqrt(d))/(2*a)}"
elsif d == 0
	puts "дискриминант #{d}, корень #{-b/(2*a)}"
elsif d < 0
	puts "дискриминант #{d}, корней нет"
end