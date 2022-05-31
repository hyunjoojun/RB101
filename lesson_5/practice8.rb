hsh = {
  first: ['the', 'quick'], second: ['brown', 'fox'],
  third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']
}

vowels = 'aeiou'

hsh.values.flatten.each do |word|
  word.chars.each do |letter|
    puts letter if vowels.include?(letter)
  end
end
