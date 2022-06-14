require 'pry'

SUITS = %w(H D C S)
VALUES = %w(2 3 4 5 6 7 8 9 10 J Q K A)

def prompt(msg)
  puts "=> #{msg}"
end

def display_welcome_message
  system 'clear'
  prompt "Welcome to Twenty-One!"
  prompt "Try to get as close to 21 as possible, without going over!"
end

def initialize_deck
  SUITS.product(VALUES).shuffle
end

def display_cards(player_cards, dealer_cards)
  prompt "Your cards: #{player_cards}, total of #{total(player_cards)}"
  prompt "Dealer's cards: #{dealer_cards[0]} + ? "
end

def total(cards)
  # cards = [['H', '3'], ['S', 'Q'], ... ]
  values = cards.map { |card| card[1] }

  sum = 0
  values.each do |value|
    if value == "A"
      sum += 11
    elsif value.to_i == 0 # J, Q, K
      sum += 10
    else
      sum += value.to_i
    end
  end

  # correct for Aces
  values.select { |value| value == "A" }.count.times do
    sum -= 10 if sum > 21
  end

  sum
end

def deal_cards(player_cards, dealer_cards)
  2.times do
    player_cards << initialize_deck.pop
    dealer_cards << initialize_deck.pop
  end
end

def busted?(cards)
  total(cards) > 21
end

def detect_result(player_cards, dealer_cards)
  player_score = total(player_cards)
  dealer_score = total(dealer_cards)

  if player_score > 21
    :player_busted
  elsif dealer_score > 21
    :dealer_busted
  elsif player_score > dealer_score
    :player
  elsif dealer_score > player_score
    :dealer
  else
    :tie
  end
end

def display_result(player_cards, dealer_cards)
  result = detect_result(player_cards, dealer_cards)

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

# Start
loop do
  player_cards = []
  dealer_cards = []

  display_welcome_message
  deck = initialize_deck
  deal_cards(player_cards, dealer_cards)
  display_cards(player_cards, dealer_cards)

  loop do
    answer = nil
    loop do
      prompt "Would you like to (h)it or (s)tay?"
      answer = gets.chomp.downcase
      break if ['h', 's'].include?(answer)
      prompt "Sorry, must enter 'h' or 's'."
    end

    if answer == 'h'
      player_cards << deck.pop
      prompt "You chose to hit!"
      display_cards(player_cards, dealer_cards)
    end

    break if answer == 's' || busted?(player_cards)
  end

    if busted?(player_cards)
      display_result(player_cards, dealer_cards)
      play_again? ? next : break
    else
      prompt "You stayed at #{total(player_cards)}"
    end

    prompt "Dealer turn..."

    loop do
      break if total(dealer_cards) >= 17

      prompt "Dealer hits!"
      dealer_cards << deck.pop
      prompt "Dealer's cards are now: #{dealer_cards}"
    end

    if busted?(dealer_cards)
      prompt "Dealer total is now: #{total(dealer_cards)}"
      display_result(player_cards, dealer_cards)
      play_again? ? next : break
    else
      prompt "Dealer stays at #{total(dealer_cards)}"
    end

      # both player and dealer stays - compare cards!
  puts "=============="
  prompt "Dealer has #{dealer_cards}, for a total of: #{total(dealer_cards)}"
  prompt "Player has #{player_cards}, for a total of: #{total(player_cards)}"
  puts "=============="

  display_result(player_cards, dealer_cards)

  break unless play_again?
end

prompt "Thanks for playing Twenty-One! Good bye!"
