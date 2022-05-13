CHOICES = {
  r: "rock",
  p: "paper",
  sc: "scissors",
  l: "lizard",
  sp: "spock"
}
WIN_MATRIX = [
  %w(tie paper rock rock spock),
  %w(paper tie scissors lizard paper),
  %w(rock scissors tie scissors spock),
  %w(rock lizard scissors tie lizard),
  %w(spock paper spock lizard tie)
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
  CHOICES.values.include?(choice)
end

def valid_letters?(letter)
  CHOICES.keys.include?(letter.to_sym)
end

def convert_letter_to_word(letter)
  CHOICES[letter.to_sym]
end

def calculate_winner(player1, player2)
  WIN_MATRIX[MAP[player1]][MAP[player2]]
end

def determine_winner(winning_hand, player_choice)
  if winning_hand == "tie"
    "tie"
  elsif winning_hand == player_choice
    "player"
  else
    "computer"
  end
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

def add_score(winner, scores)
  if winner == "player"
    scores[:player] += 1
  elsif winner == "computer"
    scores[:computer] += 1
  end
end

def display_score(scores)
  prompt("You: #{scores[:player]} ; Computer: #{scores[:computer]}")
end

def display_grand_winner(scores)
  if (scores[:player]) == 3
    prompt("The grand winner is You!")
  elsif (scores[:computer]) == 3
    prompt("The grand winner is Computer!")
  end
end

loop do
  scores = { player: 0, computer: 0 }
  loop do
    player_choice = ''
    loop do
      prompt("Please choose one: #{CHOICES.values.join(', ')}
            (You may type in the first letters)")
      player_choice = gets.chomp

      if valid_choice?(player_choice) || valid_letters?(player_choice)
        break
      else
        prompt("Invalid choice.")
      end
    end

    if valid_letters?(player_choice)
      player_choice = convert_letter_to_word(player_choice)
    end

    computer_choice = CHOICES.values.sample

    prompt("You chose: #{player_choice}; Computer chose: #{computer_choice}")

    winning_hand = calculate_winner(player_choice, computer_choice)
    winner = determine_winner(winning_hand, player_choice)
    add_score(winner, scores)

    display_results(winner)
    display_score(scores)
    display_grand_winner(scores)

    break if (scores[:player]) == 3 || (scores[:computer]) == 3
  end

  prompt("Do you want to play again?")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for playing! Good bye!")
