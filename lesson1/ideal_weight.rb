puts "Введите пожалуйста ваше имя:\n"
name = gets.chomp
puts "Здравствуйте, #{name}. Введите ваш рост:\n"
height = gets.chomp
weight = (height.to_i - 110) * 1.15
if weight > 0
	puts "#{name}, ваш оптимальный вес = #{weight} кг"
else
	puts "Ваш вес уже оптимальный"
end