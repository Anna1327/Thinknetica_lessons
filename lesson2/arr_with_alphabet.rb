#4 заполнить хеш гласными буквами
a = ['a', 'e', 'i', 'o', 'u', 'y']
b = ('a'..'z')
h = {}
count = 1
for i in b
	if a.include?(i)
		h[i] = count
	end
	count += 1
end
puts h