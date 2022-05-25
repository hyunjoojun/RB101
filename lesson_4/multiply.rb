def multiply(numbers, multiply_by)
  multiplied_numbers = []
  counter = 0

  loop do
    break if counter == numbers.size

    multiplied_numbers << numbers[counter] * multiply_by
    counter += 1
  end

  multiplied_numbers
end

my_numbers = [1, 4, 3, 7, 2, 6]
p multiply(my_numbers, 3) # => [3, 12, 9, 21, 6, 18]