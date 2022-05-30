[[1, 2], [3, 4]].map do |arr|
  puts arr.first
  arr.first
end

Line: Action : Object : Side Effect : Return Value : Is Return Value Used?
line 1 : method call (map) : The outer array : None : New array [1, 3] : No
line 1-4 : block execution : Each sub-array : None : 1, 3 : Yes used by map
line 2 : method call (first) : Each sub-array : None : 1, 3 : Yes used by puts
line 2 : method call (puts) : Element at index 0 of each sub-array : Outputs a string reperesentation of an Integer : nil : No
line 3: method call (first) : Each sub-array : None : Each at index 0 of sub-array : Yes used by map


Answer:

Prints out to the console:
1
3
Returns:
=> [1, 3]
