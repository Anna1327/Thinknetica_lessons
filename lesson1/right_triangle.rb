# frozen_string_literal: true

puts "Введите стороны треугольника через запятую:\n"
enter = gets.chomp
a, b, c = enter.split(',')
a = a.to_i
b = b.to_i
c = c.to_i

# определение самой длинной стороны
if a > b && a > c
  hypotenuse = a
  k1 = b
  k2 = c
end
if b > a && b > c
  hypotenuse = b
  k1 = a
  k2 = c
end
if c > a && c > b
  hypotenuse = c
  k1 = a
  k2 = b
end

if a == b && b == c
  puts 'Этот треугольник равнобедренный и равносторонний'
elsif (a == b) || (b == c) || (a == c)
  puts 'Этот треугольник равнобедренный'
elsif hypotenuse**2 == k1**2 + k2**2
  puts 'Этот треугольник прямоугольный'
else
  puts 'Этот треугольник не относится ни к одному виду'
end
