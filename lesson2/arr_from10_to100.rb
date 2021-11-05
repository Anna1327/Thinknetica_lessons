# frozen_string_literal: true

# 2 fill the array with numbers from 10 to 100 with a step of 5
new_arr = []
count = 10
range = (1..100)
range.each do |_i|
  if count < 101
    new_arr << count
    count += 5
  end
end
puts new_arr
