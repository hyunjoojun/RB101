arr = [[1, 6, 9], [6, 1, 7], [1, 8, 3], [1, 5, 9]]

sorted_array = arr.sort_by do |sub_arr|
  sub_arr.select do |num|
    num.odd?
  end
end

p sorted_array
