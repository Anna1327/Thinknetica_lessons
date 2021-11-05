# frozen_string_literal: true

# 6 amount of purchases

thing_name = 'старт'
h = {}
while thing_name != 'стоп'
  puts "Введите название товара, цену за единицу и кол-во купленного товара через запятую: \n"
  thing_name, price, number = gets.chomp.split(',')
  break if thing_name == 'стоп'

  price = price.to_i
  number = number.to_i
  h[thing_name] = { 'price' => price, 'number' => number }
  h[thing_name]['sum'] = price * number
end

count = 0
h.each do |_key, value|
  count += value['sum']
end
puts h
puts "Итоговая сумма всех покупок в корзине = #{count}"
