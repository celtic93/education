puts 'Введите a, b, c'
a = gets.to_i
b = gets.to_i
c = gets.to_i

d = b**2 - 4*a*c

if d >= 0
	cor = Math.sqrt(d)
	x1 = (-b + cor)/(2*a)
	x2 = (-b - cor)/(2*a)
end

if d > 0
	puts "дискриминант #{d}, корень1 #{x1}, корень2 #{x2}"
elsif d == 0
	puts "дискриминант #{d}, корень #{x1}"
elsif d < 0
	puts "дискриминант #{d}, корней нет"
end
