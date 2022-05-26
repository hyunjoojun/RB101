flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones.each_with_index do |name, idx|
  if name.start_with?("Be")
    break idx
  end
end

p flintstones.index { |name| name[0, 2] == "Be" }
