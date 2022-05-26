words = "the flintstones rock"

p words.split.map { |word| word.capitalize }.join(' ')

def titleize(words)
  capitalized_words = words.split.map do |word|
    word.capitalize!
  end
  capitalized_words.join(" ")
end

p titleize(words)
