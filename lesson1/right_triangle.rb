puts "Введите стороны треугольника через запятую:\n"
enter = gets.chomp
a,b,c = enter.split(",")
a,b,c = a.to_i, b.to_i, c.to_i

#определение самой длинной стороны
if a > b && a > c
	hypotenuse = a
	k1, k2 = b, c
end
if b > a && b > c
	hypotenuse = b
	k1, k2 = a, c
end
if c > a && c > b
	hypotenuse = c
	k1, k2 = a, b
end


if a == b && b == c
	puts "Этот треугольник равнобедренный и равносторонний"
elsif (a == b) || (b == c) || (a == c)
	puts "Этот треугольник равнобедренный"
elsif hypotenuse**2 == k1**2 + k2**2
	puts "Этот треугольник прямоугольный"
elsif
	puts "Этот треугольник не относится ни к одному виду"
end

