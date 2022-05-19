=begin
is_an_ip_number(word) = determines if word is IP numbers.

Problem with dot_separated_ip_address? method:
1. Does NOT return a false condition.
2. Only 4 components should return true.
=end

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  return false unless dot_separated_words.size == 4

  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    break unless is_an_ip_number?(word)
  end

  true
end
