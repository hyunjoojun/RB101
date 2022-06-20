require "pry"

SUITS = %w(♥ ♦ ♣ ♠)
VALUES = {
  "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9,
  "10": 10, "Jack": 10, "Queen": 10, "King": 10, "Ace": 11
}
GAME_SIZE = 21
DEALER_STAY = 17
WINNING_SCORE = 5

# Game state
def new_game_state
  { player_score: 0, dealer_score: 0, round: 0 }
end

# Round state
def round_state
  {
    deck: initialize_deck,
    player_cards: [],
    player_count: 0,
    dealer_cards: [],
    dealer_count: 0
  }
end

def prompt(msg)
  puts "=> #{msg}"
end

def display_welcome_message
  prompt "Welcome to Twenty-One!"
  prompt "First player to win 5 rounds wins the game!"
  prompt "Try to get as close to 21 as possible, without going over!"
  prompt "Detailed rules can be found here: https://bargames101.com/21-card-game-rule/"
  puts "------------------------------------"
end

def initialize_deck
  SUITS.product(VALUES.keys).shuffle
end

def valid_input?(input)
  input == 'h' || input == 's'
end

def visualize_cards(cards)
  cards.map(&:join).join(", ")
end

def display_player_status(state)
  prompt "Your cards are: #{visualize_cards(state[:player_cards])}"
  prompt "Your count is: #{state[:player_count]}"
end

def display_dealer_card(state)
  puts "------------------------------------"
  prompt "Dealer's cards: #{visualize_cards(state[:dealer_cards])[0..1]} + ? "
end

def display_dealer_state(state)
  prompt "Dealer's cards are: #{visualize_cards(state[:dealer_cards])}"
  prompt "Dealer's count is: #{state[:dealer_count]}"
end

def initial_deal(state)
  2.times do
    hit!(state, "player")
    hit!(state, "dealer")
  end
end

def display_round(state)
  state[:round] += 1
  prompt "ROUND #{state[:round]}"
end

def hit!(state, person)
  card = state[:deck].pop
  state[:"#{person}_cards"] << card
  add_card_to_count!(state, card, person)
end

def add_card_to_count!(state, card, person)
  state[:"#{person}_count"] += VALUES[card[1]]

  if busted?(state, person) && state[:"#{person}_cards"].any? do |player_card|
    player_card[1] == :Ace
  end
    total(state, person)
  end
end

def total(state, person)
  count = 0
  state[:"#{person}_cards"].each do |card|
    count += VALUES[card[1]]
  end

  state[:"#{person}_cards"].select { |p_card| p_card[1] == :Ace }.count.times do
    break unless busted?(state, person)
    count -= 10
  end

  state[:"#{person}_count"] = count
end

def add_score(game_state, state)
  if state[:player_count] > GAME_SIZE
    game_state[:dealer_score] += 1
  elsif state[:dealer_count] > GAME_SIZE
    game_state[:player_score] += 1
  elsif state[:dealer_count] < state[:player_count]
    game_state[:player_score] += 1
  elsif state[:dealer_count] > state[:player_count]
    game_state[:dealer_score] += 1
  end
end

def display_score(game_state)
  puts "======================="
  prompt "Your score: #{game_state[:player_score]}"
  prompt "Dealer score: #{game_state[:dealer_score]}"
  puts "======================="
end

def busted?(state, person)
  state[:"#{person}_count"] > GAME_SIZE
end

def hit_or_stay?
  player_choice = nil
  loop do
    prompt "Would you like to (h)it or (s)tay?"
    player_choice = gets.chomp.downcase
    break if valid_input?(player_choice)
    prompt "Sorry, must enter 'h' or 's'."
  end
  player_choice
end

def player_turn(state)
  loop do
    player_choice = hit_or_stay?

    if player_choice == "h"
      hit!(state, "player")
      prompt "You chose to hit!"
      display_player_status(state)
    end

    break if player_choice == "s" || busted?(state, "player")
  end

  if !busted?(state, "player")
    prompt "You stayed at #{state[:player_count]}"
  end
  display_dealer_state(state)
end

def dealer_turn(state)
  prompt "Dealer turn..."
  loop do
    break if state[:dealer_count] >= DEALER_STAY

    prompt "Dealer hits!"
    hit!(state, "dealer")
  end

  if !busted?(state, "dealer")
    prompt "Dealer stays at #{state[:dealer_count]}"
  end
end

def display_result(state)
  if state[:player_count] > GAME_SIZE
    prompt "You busted! Dealer wins!"
  elsif state[:dealer_count] > GAME_SIZE
    prompt "Dealer busted! You win!"
  elsif state[:dealer_count] < state[:player_count]
    prompt "You win!"
  elsif state[:dealer_count] > state[:player_count]
    prompt "Dealer wins!"
  else
    prompt "It's a tie!"
  end
end

def display_grand_winner(game_state)
  puts "********************************************"
  puts "--------------------------------------------"
  if game_state[:player_score] == WINNING_SCORE
    prompt "The grand winner is You!"
  elsif game_state[:dealer_score] == WINNING_SCORE
    prompt "The grand winner is Dealer!"
  end
  puts "--------------------------------------------"
  puts "********************************************"
end

def enter_to_continue
  prompt "Please press Enter to continue."
  loop do
    input = gets.chomp
    break if input
  end
end

def play_again?
  prompt "Do you want to play again? (y or n)"
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

def say_thanks
  prompt "Thank you for playing Twenty-One! Good bye!"
end

def start_round(game_state)
  system 'clear'
  state = round_state

  display_round(game_state)
  initial_deal(state)
  display_player_status(state)
  display_dealer_card(state)
  player_turn(state)

  if !busted?(state, "player")
    dealer_turn(state)
  end

  display_result(state)
  add_score(game_state, state)
  display_score(game_state)
  enter_to_continue
end

def start_game
  system 'clear'
  display_welcome_message
  enter_to_continue

  game_state = new_game_state
  loop do
    start_round(game_state)

    break if game_state[:player_score] == WINNING_SCORE || game_state[:dealer_score] == WINNING_SCORE
  end
  display_grand_winner(game_state)
  play_again? ? start_game : say_thanks
end

start_game
