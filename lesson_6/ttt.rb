require 'pry'

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]]              # diagonals
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
PLAYERS = ['Player', 'Computer']

def welcome_message
  Kernel.puts "Welcome to Tic Tac Toe!"
  Kernel.puts "The first one to score 5 will be the grand winner!"
end

def display_board(brd)
  Kernel.system 'clear'
  Kernel.puts([
    "You're a #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}.",
    "",
    "     |     |",
    "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}",
    "     |     |",
    "-----+-----+-----",
    "     |     |",
    "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}",
    "     |     |",
    "-----+-----+-----",
    "     |     |",
    "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}",
    "     |     |",
    "",
  ].join("\n"))
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def find_at_risk_square(line, brd, marker)
  if brd.values_at(*line).count(marker) == 2
    brd.select { |k, v| line.include?(k) && v == INITIAL_MARKER }.keys.first
  else
    nil
  end
end

def computer_decision(board)
  computer_offense(board)
  computer_defense(board)
  computer_random(board)
end

def computer_offense(board)
  square = nil

  WINNING_LINES.each do |line|
    square = find_at_risk_square(line, board, COMPUTER_MARKER)
    break if square
  end

  board[square] = COMPUTER_MARKER
  board
end

def computer_defense(board)
  square = nil

  if !square
    WINNING_LINES.each do |line|
      square = find_at_risk_square(line, board, PLAYER_MARKER)
      break if square
    end
  end

  board[square] = COMPUTER_MARKER
  board
end

def computer_random(board)
  square = nil

  if !square
    square = empty_squares(board).sample
  end

  board[square] = COMPUTER_MARKER
  board
end

def computer_pick_five(board)
  square = nil

  if !square
    square = 5 if empty_squares(board).include?(5)
  end

  board[square] = COMPUTER_MARKER
  board
end

def player_chooses(board, position)
  if board[position] == INITIAL_MARKER
    board[position] = PLAYER_MARKER
  else
    Kernel.puts "Invalid choice"
    sleep(2)
  end

  board
end

# Game start
welcome_message
sleep(2)

board = {}
(1..9).each { |num| board[num] = " " }

loop do
  display_board(board)

  Kernel.print("What position? ")
  position = gets.chomp.to_i

  board = player_chooses(board, position)
  board = computer_decision(board)

end
