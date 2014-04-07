# Procedural Black Jack Game

# Start New Game
def new_game
  values = %w(Ace 2 3 4 5 6 7 8 9 10 Jack Queen King)
  suits = %w(Spade Club Diamond Heart)
  player_hand = []
  dealer_hand = []
  
  deck = []
  values.each do |value|
    suits.each do |suit|
      deck << [value, suit]
    end
  end
  deck.shuffle! 

  player_hand << draw_card(deck) << draw_card(deck)

  puts "The player's hand is: #{player_hand[0][0]} of #{player_hand[0][1]}" + 
       " and #{player_hand[1][0]} of #{player_hand[1][1]}."

  dealer_hand << draw_card(deck) << draw_card(deck)

  puts "The dealer's hand is: #{dealer_hand[0][0]} of #{dealer_hand[0][1]}" + 
       " and #{dealer_hand[1][0]} of #{dealer_hand[1][1]}."

  dealer_turn(dealer_hand)
  # Start player's turn
  puts deck.length

end

def draw_card(deck)
  deck.slice!(0)
end

def dealer_turn(dealer_hand)
  puts "-------------------------------------"
  puts "Dealer's Turn!!"

end

def hand_total(hand)
  total = 0
  hand.each do |card|
    total += convert_to_value(card[0])
  end
  puts "total: #{total}"
  total
end

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

# new_game
# puts hand_total([[5, ""],["King", ""], ["Ace",""], [10,""]])