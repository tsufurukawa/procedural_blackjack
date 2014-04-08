# Procedural Black Jack Game - 4/7/14

# start new game
def new_game
  puts "---------------New Game-----------------"
  values = %w(Ace 2 3 4 5 6 7 8 9 10 Jack Queen King)
  suits = %w(Spade Club Diamond Heart)
  player_hand = []
  dealer_hand = []
  
  # create and shuffle deck
  deck = values.product(suits)
  deck.shuffle! 

  # dealer and player draw 2 cards each
  player_hand << draw_card(deck, "Player") << draw_card(deck, "Player")
  puts "Player Total: #{calculate_sum(player_hand)}"

  dealer_hand << draw_card(deck, "Dealer") << draw_card(deck, "Dealer")
  puts "Dealer Total: #{calculate_sum(dealer_hand)}"

  # gameplay logic
  player_result = player_turn(player_hand, deck)  # invoke player_turn method
  if player_result > 21
    puts "Player Busts. Player Loses..."
  elsif player_result == 21
    puts "BLACKJACK!!!"
  else 
    dealer_result = dealer_turn(dealer_hand, deck) # invoke dealer_turn method
    if dealer_result > 21
      puts "Dealer Busts. Player Wins!!!"
    elsif player_result > dealer_result
      puts "Player Wins!!!"
    elsif player_result < dealer_result
      puts "Dealer Wins..."
    else
      puts "Draw."
    end
  end

end

# return one card while mutating the original deck
def draw_card(deck, person)
  card = deck.slice!(0) # extract first card in deck and mutate original deck
  puts "#{person} drew a #{card[0]} of #{card[1]}."
  card
end

# dealer's turn, returns dealer's hand 
def dealer_turn(dealer_hand, deck)
  puts "----------------------------------------"
  puts "Dealer's Turn!!"

  while calculate_sum(dealer_hand) < 17 # loop until dealer hand reaches 17 or greater
    puts "Dealer Hits!"
    dealer_hand << draw_card(deck, "Dealer")  # draw one card
    dealer_total = calculate_sum(dealer_hand) # compute dealer's hand 
    puts "Dealer Total: #{dealer_total}"
    return dealer_total if dealer_total > 21 # returns if dealer busts
  end

  puts "Dealer Stays."
  calculate_sum(dealer_hand) # computes and returns dealer's hand

end

# player's turn, returns player's hand
def player_turn(player_hand, deck)
  puts "----------------------------------------"
  puts "Player's Turn!!"

  # infinite loop, breaks on "stay" or when player busts
  loop do 
    print "Please enter 'hit' or 'stay': "
    hit_or_stay = gets.chomp

    # goes back to start of loop if user types anything other than 'hit' or 'stay'
    next unless hit_or_stay.downcase == 'hit' || hit_or_stay.downcase == 'stay' 
    
    if hit_or_stay.downcase == 'hit'
      puts "Player Hits!!"
      player_hand << draw_card(deck, "Player") # draws a card from deck
      puts "Player Total: #{calculate_sum(player_hand)}"

      break if calculate_sum(player_hand) > 21 # breaks out of loop if player busts
    else
      break # breaks out of loop if player types 'stay'
    end
  end

  calculate_sum(player_hand) # computes and returns player's hand
end

# computes and returns dealer / player's hand
def calculate_sum(hand)
  total = 0 # keep track of sum of cards 
  ace_count = 0 # keep track of number of aces

  # iterates through hand to compute the total value of the given hand 
  # and to count # of Ace's in the hand 
  hand.each do |card|  
    total += convert_to_value(card[0]) 
    ace_count += 1 if card[0] == "Ace"
  end

  # the Ace will take on value of 1 (instead of 11) if and only if 
  # the hand includes an Ace and the player/dealer busts upon hitting
  ace_count.times do 
    total -= 10 if total > 21  
  end                          
                               
  total # returns total value of given hand
end

# converts string values into numerical values, since deck is represented by an array of strings
def convert_to_value(card)
  if card.to_i != 0 # For non face cards
    card.to_i
  else
    case card
    when "Ace" then 11
    when "Jack", "Queen", "King" then 10
    end
  end
end

# game repeats until user types "no"
loop do
  new_game # starts new game
  puts "----------------------------------------"
  
  loop do
    print "Play Again (yes or no)? "
    play_again = gets.chomp
    if play_again.downcase == "no"
      exit
    elsif play_again.downcase == "yes"
      break
    else 
      puts "Please enter 'yes' or 'no'."
    end
  end
end