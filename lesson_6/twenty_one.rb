require 'pry'

SUITS = %w(♥ ♦ ♣ ♠)
VALUES = {
  "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9,
  "10": 10, "Jack": 10, "Queen": 10, "King": 10, "Ace": 11
}
GAME_SIZE = 21
DEALER_STAY = 17

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

def valid_input?(input)
  input == 'h' || input == 's'
end

def display_cards(cards)
  cards.map(&:join).join(", ")
end

def total(cards)
  values = cards.map { |card| VALUES[card[1]] }

  sum = 0
  values.each { |value| sum += value }

  # correct for Aces
  cards.each do |card|
    sum -= 10 if card[1] == :Ace && sum > 21
  end

  sum
end

def add_to_total(cards, total)
  total += VALUES[cards.last[1]]

  cards.select { |card| card[1] == :Ace }.count.times do
    total -= 10 if total > 21
  end

  total
end

def busted?(total)
  total > GAME_SIZE
end

# :tie, :dealer, :player, :dealer_busted, :player_busted
def detect_result(dealer_total, player_total)
  if player_total > GAME_SIZE
    :player_busted
  elsif dealer_total > GAME_SIZE
    :dealer_busted
  elsif dealer_total < player_total
    :player
  elsif dealer_total > player_total
    :dealer
  else
    :tie
  end
end

def display_result(dealer_total, player_total)
  result = detect_result(dealer_total, player_total)

  case result
  when :player_busted
    prompt "You busted! Dealer wins!"
  when :dealer_busted
    prompt "Dealer busted! You win!"
  when :player
    prompt "You win!"
  when :dealer
    prompt "Dealer wins!"
  when :tie
    prompt "It's a tie!"
  end
end

def play_again?
  puts "-------------"
  prompt "Do you want to play again? (y or n)"
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

loop do
  system 'clear'
  display_welcome_message

  # initialize vars
  deck = initialize_deck
  player_cards = []
  dealer_cards = []

  # initial deal
  2.times do
    player_cards << deck.pop
    dealer_cards << deck.pop
  end

  player_total = total(player_cards)
  dealer_total = total(dealer_cards)

  prompt "Your cards: #{display_cards(player_cards)}, total: #{player_total}"
  prompt "Dealer's cards: #{display_cards(dealer_cards)[0..1]} + ? "

  # player turn
  loop do
    player_turn = nil
    loop do
      prompt "Would you like to (h)it or (s)tay?"
      player_turn = gets.chomp.downcase
      break if valid_input?(player_turn)
      prompt "Sorry, must enter 'h' or 's'."
    end

    if player_turn == 'h'
      player_cards << deck.pop
      player_total = add_to_total(player_cards, player_total)
      prompt "You chose to hit!"
      prompt "Your cards are now: #{display_cards(player_cards)}"
      prompt "Your total is now: #{player_total}"
    end

    break if player_turn == 's' || busted?(player_total)
  end

  if busted?(player_total)
    display_result(dealer_total, player_total)
    play_again? ? next : break
  else
    prompt "You stayed at #{player_total}"
  end

  # dealer turn
  prompt "Dealer turn..."

  loop do
    break if dealer_total >= DEALER_STAY

    prompt "Dealer hits!"
    dealer_cards << deck.pop
    dealer_total = add_to_total(dealer_cards, dealer_total)
    prompt "Dealer's cards are now: #{display_cards(dealer_cards)}"
  end

  if busted?(dealer_total)
    prompt "Dealer total is now: #{dealer_total}"
    display_result(dealer_total, player_total)
    play_again? ? next : break
  else
    prompt "Dealer stays at #{dealer_total}"
  end

  # both player and dealer stays - compare cards!
  puts "=============="
  prompt "Dealer has #{display_cards(dealer_cards)}, for a total of: #{dealer_total}"
  prompt "Player has #{display_cards(player_cards)}, for a total of: #{player_total}"
  puts "=============="

  display_result(dealer_total, player_total)

  break unless play_again?
end

prompt "Thank you for playing Twenty-One! Good bye!"
