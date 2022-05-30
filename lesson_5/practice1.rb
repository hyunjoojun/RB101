arr = ['10', '11', '9', '7', '8']

sorted_array = arr.sort do |a, b|
  b.to_i <=> a.to_i
end

p sorted_array
