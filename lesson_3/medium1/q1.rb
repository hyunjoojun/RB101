=begin
Write one-line program that creates the following output 10 times.
output = The Flintsones Rock!
** Subsequent line indented 1 space to the right
=end

10.times { |num| puts (" " * num) + "The Flintstones Rock!" }
