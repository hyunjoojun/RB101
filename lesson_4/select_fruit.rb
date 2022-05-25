produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

def select_fruit(produce_list)
  selected_fruits = {}

  produce_list.each do |produce, type|
    if type == 'Fruit'
      selected_fruits[produce] = type
    end
  end
  selected_fruits
end

# def select_fruit(produce_list)
#   produce_keys = produce_list.keys
#   selected_fruits = {}
#   counter = 0

#   loop do
#     break if counter == produce_keys.size

#     current_key = produce_keys[counter]
#     current_value = produce_list[current_key]

#     if current_value == 'Fruit'
#       selected_fruits[current_key] = current_value
#     end

#     counter += 1
#   end

#   selected_fruits
# end

p select_fruit(produce)