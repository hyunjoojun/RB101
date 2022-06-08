WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]]              # diagonals
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
PLAYERS = ['Player', 'Computer']

# rubocop: disable Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts "You're a #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop: enable Metrics/AbcSize

def prompt(msg)
  puts "=> #{msg}"
end

def display_welcome_message
  prompt "Welcome to Tic-Tac-Toe!"
  prompt "First player to win 5 rounds wins the game!"
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def joinor(list, sign=', ', word='or')
  case list.size
  when 0 then ''
  when 1 then list.first
  when 2 then list.join(" #{word} ")
  else
    list[-1] = "#{word} #{list.last}"
    list.join(sign)
  end
end

def decide_first_turn
  first_turn = ''

  loop do
    prompt "Do you want to decide who goes first? (Y or N)"
    answer = gets.chomp.upcase

    if answer == 'Y'
      first_turn = who_goes_first?
    elsif answer == 'N'
      first_turn = random_turn
    end

    break if answer == 'Y' || answer == 'N'
    prompt "Invalid choice. Please enter Y or N."
  end
  first_turn
end

def random_turn
  first_turn = PLAYERS.sample

  display_first_turn(first_turn)
  sleep(2)
  first_turn
end

def player_chooses_turn
  prompt "Who is going first? (P for Player / C for Computer)"
  first_turn = gets.chomp.upcase

  if first_turn == "P"
    first_turn = 'Player'
  elsif first_turn == "C"
    first_turn = 'Computer'
  end

  first_turn
end

def who_goes_first?
  first_turn = ''

  loop do
    first_turn = player_chooses_turn
    display_first_turn(first_turn)
    sleep(2)

    break if first_turn == 'Player' || first_turn == 'Computer'
  end
  first_turn
end

def display_first_turn(first_turn)
  if first_turn == 'Player'
    prompt "Player is going first!"
  elsif first_turn == 'Computer'
    prompt "Computer is going first!"
  else
    prompt "Invalid choice."
  end
end

def game_rounds(brd, current_player)
  loop do
    display_board(brd)
    place_piece!(brd, current_player)
    current_player = alternate_player(current_player)
    break if someone_won?(brd) || board_full?(brd)
  end
end

def place_piece!(brd, current_player)
  if current_player == 'Player'
    player_places_piece!(brd)
  else
    computer_places_piece!(brd)
  end
end

def alternate_player(current_player)
  PLAYERS.select { |player| player != current_player }.first
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a position to place a piece: #{joinor(empty_squares(brd))}"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end

  brd[square] = PLAYER_MARKER
end

def find_at_risk_square(line, brd, marker)
  if brd.values_at(*line).count(marker) == 2
    brd.select { |k, v| line.include?(k) && v == INITIAL_MARKER }.keys.first
  end
end

def strategic_square(brd, marker)
  WINNING_LINES.each do |line|
    square = find_at_risk_square(line, brd, marker)
    return square if square
  end
  nil
end

def computer_places_piece!(brd)
  # offense first
  square = strategic_square(brd, COMPUTER_MARKER)

  # defense
  if !square
    square = strategic_square(brd, PLAYER_MARKER)
  end

  # pick square 5 or random
  if !square
    square = empty_squares(brd).include?(5) ? 5 : empty_squares(brd).sample
  end

  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def add_score(brd, scores)
  if detect_winner(brd) == 'Player'
    scores[:player] += 1
  elsif detect_winner(brd) == 'Computer'
    scores[:computer] += 1
  end
  scores
end

def display_score(scores)
  prompt "Player: #{scores[:player]} ; Computer: #{scores[:computer]}"
end

def display_round_winner(brd)
  if someone_won?(brd)
    prompt "#{detect_winner(brd)} won!"
  else
    prompt "It's a tie!"
  end
end

def display_grand_winner(scores)
  if (scores[:player]) == 5
    prompt "The grand winner is You!"
  elsif (scores[:computer]) == 5
    prompt "The grand winner is Computer!"
  end
end

# main loop
loop do
  scores = { player: 0, computer: 0 }
  display_welcome_message

  loop do
    board = initialize_board
    current_player = decide_first_turn

    game_rounds(board, current_player)
    display_board(board)
    display_round_winner(board)
    add_score(board, scores)
    display_score(scores)

    prompt "Press Enter to continue."
    loop do
      input = gets.chomp
      break if input
    end

    break if scores[:player] == 5 || scores[:computer] == 5
  end

  display_grand_winner(scores)

  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic-Tac-Toe! Good bye!"
