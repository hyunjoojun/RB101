ages = {
  "Herman" => 32, "Lily" => 30, "Grandpa" => 5843,
  "Eddie" => 10, "Marilyn" => 22, "Spot" => 237
}

smallest_age = Float::INFINITY
ages.values.each do |age|
  if age < smallest_age
    smallest_age = age
  end
end

p smallest_age

p ages.values.min