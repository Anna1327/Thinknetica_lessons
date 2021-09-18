 puts "Введите длину основания треугольника:\n"
a = gets.chomp
 puts "Введите высоту треугольника:\n"
h = gets.chomp
square = 1.0 / 2 * a.to_i * h.to_i
puts "Площадь треугольника = #{square}"