# frozen_string_literal: true

# 4 fill hash with vowels
a = %w[a e i o u y]
b = ('a'..'z')
h = {}
count = 1
b.each do |i|
  h[i] = count if a.include?(i)
  count += 1
end
puts h
