=begin
1. Elements are added to rolling buffer.
2. If rolling buffer is full, new element will replace the oldest element.
=end

def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element]
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

=begin
rolling_buffer1 will mutate buffer.
If we don't want the original buffer to mutate, I will pick rolling_buffer2.
=end
