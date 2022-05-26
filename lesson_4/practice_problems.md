** Practice Problem 1
[1, 2, 3].select do |num|
  num > 5
  'hi'
end

=> [1, 2, 3]
The block retuns 'hi' which is truthy value,
so select will return all the numbers in the array.

--------------

** Practice Problem 2
['ant', 'bat', 'caterpillar'].count do |str|
  str.length < 4
end

=> 2
Goes through each elements and
if block returns true, count increases by 1

--------------

** Practice Problem 3
[1, 2, 3].reject do |num|
  puts num
end

=> [1, 2, 3]
If the return value of the block is false or nil,
the elements from the array is selected and returned.
Since puts num returns nil, all numbers are selected.

--------------

** Practice Problem 4
['ant', 'bear', 'cat'].each_with_object({}) do |value, hash|
  hash[value[0]] = value
end

=> { "a" => "ant", "b" => "bear", "c" => "cat" }
Each method will iterate through each words, so first value is 'ant'.
value[0] means the first letter which is 'a'.
Since the object is set to hash{},
'a' is set to the key of hash, and the word is set to value.
When the iteration is over, it returns the final hash.

--------------

** Practice Problem 5
hash = { a: 'ant', b: 'bear' }
hash.shift

=> [:a, "ant"]
shift method will remove the first pair of the hash.
It returns an array of that removed key and value.
The original hash will be mutated.
hash = { b: => 'bear' }

--------------

** Practice Problem 6
['ant', 'bear', 'caterpillar'].pop.size

=> 11
pop method will remove the last element and returns that element.
size is called on the return value of pop which is 'caterpillar'.
'caterpillar' has 11 characters so the final return value is 11.

--------------

** Practice Problem 7
[1, 2, 3].any? do |num|
  puts num
  num.odd?
end

=> Both block and any? will return true.
The block's last expression is 3.odd? which returns true.
any? method returns true because odd number exists in the array.

--------------

** Practice Problem 8
arr = [1, 2, 3, 4, 5]
arr.take(2)

=> [1, 2]
take method takes first (n) elements from the array and returns them.
It is not a destructive method and the original array stays the same.
Read documentation and test it out in irb.

--------------

** Practice Problem 9
{ a: 'ant', b: 'bear' }.map do |key, value|
  if value.size > 3
    value
  end
end

=> [nil, "bear"]
map method returns a new array.
The first value 'ant' evaluates as false by the if condition.
The if statement returns nil.
The last value evaluates as true and returns the value according to the block.

--------------

** Practice Problem 10
[1, 2, 3].map do |num|
  if num > 1
    puts num
  else
    num
  end
end

=> [1, nil, nil]
map method returns a new array with block's return value.
1 is returned because according to the block, it returns itself.
2 and 3 returned nil because of puts method.
