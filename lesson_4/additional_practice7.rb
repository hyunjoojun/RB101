statement = "The Flintstones Rock"

frequency_hash = {}
statement.delete(" ").chars.each do |char|
  frequency = statement.count(char)
  frequency_hash[char] = frequency
end

p frequency_hash


result = {}
letters = ('A'..'Z').to_a + ('a'..'z').to_a

letters.each do |letter|
  letter_frequency = statement.count(letter)
  result[letter] = letter_frequency if letter_frequency > 0
end

p result


p frequency_hash == result
