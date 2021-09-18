puts "Введите значения коэффициентов a, b и с через запятую:\n"
enter = gets.chomp
a,b,c = enter.split(",")
a,b,c = a.to_i, b.to_i, c.to_i
d = b**2 - 4*a*c
if d > 0
	k1 = (-b + Math.sqrt(d))/(2.0*a)
	k2 = (-b - Math.sqrt(d))/(2.0*a)
	puts "Дискриминант = #{d}, корень1 = #{k1}, корень2 = #{k2}"
elsif d == 0
	k = -b /(2.0*a)
	puts "Дискриминант = #{d}, корень = #{k}"
elsif d < 0
	puts "Дискриминант = #{d}, корней нет"
end