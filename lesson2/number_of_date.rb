#5 порядковый номер даты
puts "Введите день, месяц, год через запятую: \n"
day, month, year = gets.chomp.split(',')
day, month, year = day.to_i, month.to_i, year.to_i

months = { '1' => 31, '2' => 28, '3' => 31, '4' => 30, '5' => 31, '6' => 30, '7' => 31, '8' => 31, '9' => 30, '10' => 31, '11' => 30, '12' => 31 }

#определение високосного года
if year % 4 == 0 || (year % 100 != 0 && year % 400 == 0)
	months['2'] = 29
end

count = 0
if month > 1
	finish = month-1
	range = (1..finish)
	for i in range
		count += months[String(i)]
	end
	count += day
else
	count += day
end

puts "День #{day}.#{month}.#{year} - это #{count}-ый день в году"