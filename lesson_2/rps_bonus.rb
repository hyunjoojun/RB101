VALID_CHOICES = %w(rock paper scissors lizard spock)
VALID_LETTERS = %w(r p sc l sp)
WIN_MATRIX = [
  %w(tie paper rock rock spock),
  %w(paper tie scissors lizard paper),
  %w(rock scissors tie scissors spock),
  %w(rock lizard scissors tie lizard),
  %w(spock paper spock lizard tie),
]
MAP = {
  'rock' => 0,
  'paper' => 1,
  'scissors' => 2,
  'lizard' => 3,
  'spock' => 4
}

def prompt(message)
  puts "=> #{message}"
end

def valid_choice?(choice)
  VALID_CHOICES.include?(choice)
end

def valid_letters?(letter)
  VALID_LETTERS.include?(letter)
end

def convert_letter_to_word(letter)
  VALID_CHOICES.each do |word|
    if word.start_with?(letter)
      return word
    end
  end
end

def calculate_winner(player1, player2)
  WIN_MATRIX[MAP[player1]][MAP[player2]]
end

def display_results(winner)
  if winner == 'tie'
    prompt("It's a tie!")
  elsif winner == "player"
    prompt("You won!")
  else
    prompt("Computer won!")
  end
end

$player_score = 0
$computer_score = 0

def score(winner)
  if winner == "player"
    $player_score += 1
  elsif winner == "computer"
    $computer_score +=1
  end
end

if ENV["TEST"] != "true"
  loop do
    player_choice = ''
    loop do
      prompt("Please choose one: #{VALID_CHOICES.join(', ')} (You may type the first letter)")
      player_choice = gets.chomp

      if valid_choice?(player_choice) || valid_letters?(player_choice)
        break
      else
        prompt("Invalid choice.")
      end
    end

    player_choice = convert_letter_to_word(player_choice) if valid_letters?(player_choice)

    computer_choice = VALID_CHOICES.sample

    prompt("You chose: #{player_choice}; Computer chose: #{computer_choice}")
    winning_hand = calculate_winner(player_choice, computer_choice)
    winner = if winning_hand == "tie"
      "tie"
    elsif winning_hand == player_choice
      "player"
    else
      "computer"
    end

    display_results(winner)

    score(winner)

    prompt("You: #{$player_score}; Computer: #{$computer_score}")
    break if $player_score == 3 || $computer_score == 3
  end

  if $player_score >= 3
    prompt("The grand winner is You!")
  else
    prompt("The grand winner is Computer!")
  end

  prompt("Thank you for playing! Good bye!")
    else
  puts "Test env...skipping"
end