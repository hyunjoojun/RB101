[[1, 2], [3, 4]].map do |arr|
  arr.map do |num|
    num * 2
  end
end

Line: Action : Object : Side Effect : Return Value : Is Return Value Used?
line 1 : method call(map) : The outer array : None : New array [[2, 4], [6, 8]] : No
line 2 : method call(map) : The inner arrays : None : [2, 4], [6, 8] : Yes
line 3 : * 2 : integers : None : integers * 2 : Yes used by map
line 2-4 : block execution : Each integers : None : integers * 2 : Yes by map
line 1-5 : block execution : Each sub-array : None : New array : Yes


Answer:

Returns:
=> [[2, 4], [6, 8]]
