puts 'Введите 3 стороны'
a = gets.to_i
b = gets.to_i
c = gets.to_i

if a**2 == b**2 + c**2 || b**2 == c**2 + a**2 || c**2 == a**2 + b**2
	puts 'Треугольник прямоугольный'
	if a == b || b == c || a == c
		puts 'Треугольник равнобедренный'
	end
else
	 puts 'Треугольник не прямоугольный'
end
