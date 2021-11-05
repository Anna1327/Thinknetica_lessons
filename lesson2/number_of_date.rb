# frozen_string_literal: true

# 5 serial number of the date
puts "Введите день, месяц, год через запятую: \n"
day, month, year = gets.chomp.split(',')
day = day.to_i
month = month.to_i
year = year.to_i

months = { '1' => 31, '2' => 28, '3' => 31, '4' => 30, '5' => 31, '6' => 30, '7' => 31, '8' => 31, '9' => 30,
           '10' => 31, '11' => 30, '12' => 31 }

# definition of a leap year
months['2'] = 29 if year % 4.zero? || (year % 100 != 0 && year % 400.zero?)

count = 0
if month > 1
  finish = month - 1
  range = (1..finish)
  range.each do |i|
    count += months[String(i)]
  end
end
count += day

puts "День #{day}.#{month}.#{year} - это #{count}-ый день в году"
