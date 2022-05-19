answer = 42

def mess_with_it(some_number)
  some_number += 8
end

new_answer = mess_with_it(answer)

p answer - 8
p new_answer

# 42 - 8 which will print 34; new_answer will be 50