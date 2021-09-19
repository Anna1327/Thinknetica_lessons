#3 числа фибонначи от 1 до 100
new_arr = []
count, num = 1, 0
def fib(n)
	return n <= 1 ? n : fib(n - 1) + fib(n - 2)
end
while fib(count) < 101
	num = fib(count)
	count += 1
	new_arr << num
end
puts new_arr