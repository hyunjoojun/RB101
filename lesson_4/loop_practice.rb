# loop do
#   puts 'Just keep printing...'
#   break
# end

# loop do
#   puts 'This is the outer loop.'

#   loop do
#     puts 'This is the inner loop.'
#     break
#   end

#   break
# end

# puts 'This is outside all loops.'

# iterations = 1

# loop do
#   puts "Number of iterations = #{iterations}"
#   iterations += 1
#   break if iterations > 5
# end

# loop do
#   puts 'Should I stop looping?'
#   answer = gets.chomp
#   break if answer == 'yes'
#   puts 'Incorrect answer. Please answer "yes".'
# end

# say_hello = true
# count = 0

# while say_hello
#   puts 'Hello!'
#   count += 1
#   say_hello = false if count == 5
# end

# numbers = []

# while numbers.length < 5
#   numbers << rand(0..99)
# end

# puts numbers

# count = 1

# until count > 10
#   puts count
#   count += 1
# end

# numbers = [7, 9, 13, 25, 18]
# puts numbers.shift until numbers.length == 0

# for i in 1..100
#   puts i if i % 2 == 1
# end

friends = ['Sarah', 'John', 'Hannah', 'Dave']

for friend in friends
  puts "Hello, #{friend}!"
end
