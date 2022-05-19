# def factors(number)
#   divisor = number
#   factors = []
#   begin
#     factors << number / divisor if number % divisor == 0
#     divisor -= 1
#   end until divisor == 0
#   factors
# end

def factors(number)
  divisor = number
  factors = []
  while divisor > 0
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end
  factors
end

p factors(5)
p factors(10)
p factors(4)
p factors(34)

# Bonus1 = It shows you the divisor divide number evenly with no remainder
# which are the factors of the number.
# Bonus2 = factors on line 18 will return factors array.