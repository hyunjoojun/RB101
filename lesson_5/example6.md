[{ a: 'ant', b: 'elephant' }, { c: 'cat' }].select do |hash|
  hash.all? do |key, value|
    value[0] == key.to_s
  end
end
# => [{ :c => "cat" }]

value[0] = the first letter of value
The line 3 compares the first letter of value to key.to_s (string version of the key)
First pair of the first hash == true
second pair of the first hash == false
hash.all? returns false for the first hash.

Second hash returns true for hash.all.

The select method will select the second hash only and returns it.
which gives us [{ :c => "cat" }]

If we used any? instead of all? It will return both hashes in the array.
=> [{ a: 'ant', b: 'elephant' }, { c: 'cat' }]
