#6 сумма покупок

thing_name = "старт"
h = {}
while thing_name != "стоп" do
	puts "Введите название товара, цену за единицу и кол-во купленного товара через запятую: \n"
	thing_name, price, number = gets.chomp.split(',')
	if thing_name == "стоп"
		break
	else
		price, number = price.to_i, number.to_i
		h[thing_name] = {"price" => price, "number" => number}
		h[thing_name]["sum"] = price * number
	end
end

count = 0
h.each do |key, value|
	count += value['sum']
end
puts h
puts "Итоговая сумма всех покупок в корзине = #{count}"