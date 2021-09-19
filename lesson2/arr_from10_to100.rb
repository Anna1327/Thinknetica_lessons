#2 заполнить массив числами от 10 до 100 с шагом 5
new_arr = []
count = 10
range = (1..100)
for i in range 
	if count < 101
		new_arr << count
		count += 5
	end
end
puts new_arr