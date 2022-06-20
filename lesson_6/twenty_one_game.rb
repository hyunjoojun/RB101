require "pry"

SUITS = %w(♥ ♦ ♣ ♠)
VALUES = {
  "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9,
  "10": 10, "Jack": 10, "Queen": 10, "King": 10, "Ace": 11
}
GAME_SIZE = 21
DEALER_STAY = 17

# Game state
def new_game_state
{
  player_score: 0,
  dealer_score: 0
}
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
  prompt "Try to get as close to 21 as possible, without going over!"
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

def hit!(state, person)
  card = state[:deck].pop
  state[:"#{person}_cards"] << card
  add_card_to_count!(state, card, person)
end

def add_card_to_count!(state, card, person)
  state[:"#{person}_count"] += VALUES[card[1]]

  # correct for Aces
  state[:"#{person}_cards"].select { |p_card| p_card[1] == :Ace }.count.times do
    state[:"#{person}_count"] -= 10 if state[:"#{person}_count"] > 21
  end
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
    display_player_status(state)
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
  display_dealer_state(state)
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

def play_again?
  puts "-------------"
  prompt "Do you want to play again? (y or n)"
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

def start_round
  system 'clear'
  display_welcome_message
  state = round_state

  2.times do
    hit!(state, "player")
    hit!(state, "dealer")
  end

  display_player_status(state)
  display_dealer_card(state)

  player_turn(state)

  if !busted?(state, "player")
    dealer_turn(state)
  end

  display_result(state)
end

def start_game
  state = new_game_state
end

start_game
start_round