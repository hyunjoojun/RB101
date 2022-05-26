ages = {
  "Herman" => 32, "Lily" => 30,
  "Grandpa" => 402, "Eddie" => 10
}

ages.select do |_, age|
  age < 100
end

ages.keep_if { |_, age| age < 100 }
