require 'pry'

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]]              # diagonals
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
PLAYERS = ['Player', 'Computer']

def prompt(msg)
  puts "=> #{msg}"
end

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

def who_goes_first?
  first_turn = PLAYERS.sample

  if first_turn == "Player"
    prompt "Player is going first!"
  else
    prompt "Computer is going first!"
  end
  sleep(3)
  first_turn
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
  else
    nil
  end
end

def computer_places_piece!(brd)
  square = nil

  # offense first
  WINNING_LINES.each do |line|
    square = find_at_risk_square(line, brd, COMPUTER_MARKER)
    break if square
  end

  # defense
  if !square
    WINNING_LINES.each do |line|
      square = find_at_risk_square(line, brd, PLAYER_MARKER)
      break if square
    end
  end

  # pick square 5 if available
  if !square
    square = 5 if empty_squares(brd).include?(5)
  end

  # just pick a square
  if !square
    square = empty_squares(brd).sample
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

def display_grand_winner(scores)
  if (scores[:player]) == 5
    prompt "The grand winner is You!"
  elsif (scores[:computer]) == 5
    prompt "The grand winner is Computer!"
  end
end

loop do
  scores = { player: 0, computer: 0 }
  prompt "Welcome to Tic Tac Toe!"
  prompt "The first one to score 5 will be the grand winner!"

  loop do
    board = initialize_board
    current_player = who_goes_first?

    loop do
      display_board(board)
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)
      break if someone_won?(board) || board_full?(board)
    end

    display_board(board)

    if someone_won?(board)
      prompt "#{detect_winner(board)} won!"
    else
      prompt "It's a tie!"
    end

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

prompt "Thanks for playing Tic Tac Toe! Good bye!"
