puts 'Введите 3 стороны'
a = gets.to_i
b = gets.to_i
c = gets.to_i

#строка
if a**2 == b**2 + c**2 || b**2 == c**2 + a**2 || c**2 == a**2 + b**2
	puts 'Треугольник прямоугольный'
elsif a == b && b == c 	 
	puts 'Треугольник равносторонний'
elsif a == b || b == c || a == c
	puts 'Треугольник равнобедренный'
else
	puts 'Треугольник ни прямоугольный, ни равнобедренный, ни равносторонний'
end
