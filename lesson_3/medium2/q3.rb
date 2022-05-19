def tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param << "rutabaga"
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

=begin
my_string = "pumkins"
my_array = ["pumkins", "rutabaga"]
The string did not get mutated because += operation created new String object.
my_array is mutated because << will mutate the original array.
=end
