require "pry"

SUITS = %w(♥ ♦ ♣ ♠)
VALUES = {
  "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9,
  "10": 10, "Jack": 10, "Queen": 10, "King": 10, "Ace": 11
}

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

def display_cards(state)
  player_card_string = state[:player_cards].map(&:join).join(" + ")
  dealer_card_strings = state[:dealer_cards].map(&:join)

  prompt "Your cards: #{player_card_string}, total of #{total(state[:player_cards])}"
  prompt "Dealer's cards: #{dealer_card_strings[0]} + ? "
end

def total(cards)
  # cards = [['H', '3'], ['S', 'Q'], ... ]
  values = cards.map { |card| card[1] }

  sum = 0
  values.each do |value|
    sum += if value == "A"
             11
           elsif value.to_i == 0
             10
           else
             value.to_i
           end
    # if value == "A"
    #   sum += 11
    # elsif value.to_i == 0 # J, Q, K
    #   sum += 10
    # else
    #   sum += value.to_i
    # end
  end

  # correct for Aces
  values.select { |value| value == "A" }.count.times do
    sum -= 10 if sum > 21
  end

  sum
end

def hit_or_stay?
  loop do
    prompt "Would you like to (h)it or (s)tay?"
    choice = gets.chomp.downcase
    break choice
  end
end

def hit!(state)
  card = state[:deck].pop
  state[:player_cards] << card
  state[:player_count] += VALUES[card]
end

def update_count(state, card)
  current_cards = state[:player_cards].map { |card| card.last }
end

def player_turn(state)
  loop do
    puts "hit or stay?"
    answer = gets.chomp.downcase

    if answer == "h"
      # hit
      state[:player_cards] << state[:deck].pop
      # update count
      break if busted?
    else
      break
    end
  end
end

def total(cards)
  values = cards.map { |card| VALUES[card[1].to_sym] }

  sum = 0
  values.each { |value| sum += value }

  # correct for Aces
  cards.each do |card|
    sum -= 10 if card[1] == :Ace && sum > 21
  end

  sum
end

def start_round
  state = round_state

  state[:player_cards] << state[:deck].pop << state[:deck].pop
  state[:player_count] = total(state[:player_cards])
  state[:dealer_cards] << state[:deck].pop << state[:deck].pop
  state[:dealer_count] = total(state[:dealer_cards])

  display_cards(state)
  player_turn
end

# Game state
{
  player_score: 0,
  dealer_score: 0,
}

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

def start_game(iterations = ENV["ITERATIONS"].to_i)
  i = 0
  loop do # starts the game
    break if i == iterations

    display_welcome_message
    start_round

    i += 1
  end
end

start_game