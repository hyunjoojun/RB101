my_arr = [[18, 7], [3, 12]].each do |arr|
  arr.each do |num|
    if num > 5
      puts num
    end
  end
end

Line: Action : Object : Side Effect : Return Value : Is Return Value Used?
line 1 : variable assignment : The outer array : None : Original array : No
line 1 : method call (each) : The outer array : None : Original array : Yes used by my_arr
line 2 : method call (each) : The inner sub arrays : None : Inner arrays : Yes
line 1-7 : block execution : Each sub-array : None : Each sub array : No
line 2-6 : block executuion : Each integers : None : nil : No
line 3 : comparison : Each integers : None : Boolean : Yes used by if
line 3-5 : if statement : Each integers : None : nil : Yes
line 4 : method call (puts) : Integers 18, 7, 12 : Outputs a string representationof an integer : nil : Yes


Answer:

Prints out to the console:
18
7
12
Returns:
=> [[18, 7], [3, 12]]
