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
  dealer_score: 0,
}
end

# Round state
def round_state
  {
    deck: initialize_deck,
    player_cards: [],
    player_count: 0,
    dealer_cards: [],
    dealer_count: 0,
  }
end

def prompt(msg)
  puts "=> #{msg}"
end

def display_welcome_message
  prompt "Welcome to Twenty-One!"
  prompt "Try to get as close to 21 as possible, without going over!"
end

def initialize_deck
  SUITS.product(VALUES.keys).shuffle
end

def visualize_cards(cards)
  cards.map(&:join).join(", ")
end

def display_player_status(state)
  puts "------------------------------------"
  prompt "Your cards are now: #{visualize_cards(state[:player_cards])}"
  prompt "Your count is now: #{state[:player_count]}"
end

def display_dealer_card(state)
  puts "------------------------------------"
  prompt "Dealer's cards: #{visualize_cards(state[:dealer_cards])[0..1]} + ? "
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

def player_turn(state)
  loop do
    prompt "Would you like to (h)it or (s)tay?"
    answer = gets.chomp.downcase

    if answer == "h"
      hit!(state, "player")
      break if busted?(state, "player")
    else
      break
    end
  end
end

def start_round
  display_welcome_message
  state = round_state

  2.times do
    hit!(state, "player")
    hit!(state, "dealer")
  end

  display_player_status(state)
  display_dealer_card(state)

  player_turn(state)
end

def start_game(iterations = ENV["ITERATIONS"].to_i)
  i = 0
  loop do # starts the game
    break if i == iterations

    display_welcome_message
    start_round

    i += 1
  end
end

# start_game
# start_round