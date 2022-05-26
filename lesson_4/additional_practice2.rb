ages = {
  "Herman" => 32, "Lily" => 30, "Grandpa" => 5843,
  "Eddie" => 10, "Marilyn" => 22, "Spot" => 237
}

p ages.values.sum

total_ages = 0
ages.values.each { |age| total_ages += age }
p total_ages

total_ages = 0
ages.each { |_, age| total_ages += age }
p total_ages

p ages.values.inject(:+)
