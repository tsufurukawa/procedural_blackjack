# Procedural Black Jack Game

# Start New Game
def new_game
  values = %w(Ace 2 3 4 5 6 7 8 9 10 Jack Queen King)
  suits = %w(Spade Club Diamond Heart)
  player_hand = []
  dealer_hand = []
  
  deck = values.product(suits)
  deck.shuffle! 

  player_hand << draw_card(deck) << draw_card(deck)

  puts "The player's hand is: #{player_hand[0][0]} of #{player_hand[0][1]}" + 
       " and #{player_hand[1][0]} of #{player_hand[1][1]}."

  dealer_hand << draw_card(deck) << draw_card(deck)

  puts "The dealer's hand is: #{dealer_hand[0][0]} of #{dealer_hand[0][1]}" + 
       " and #{dealer_hand[1][0]} of #{dealer_hand[1][1]}."

  dealer_turn(dealer_hand, deck)

  puts "Again: remaining cards: #{deck.length}"
  puts "Again: dealer card count: #{dealer_hand.length}"
end

def draw_card(deck)
  deck.slice!(0)
end

def dealer_turn(dealer_hand, deck)
  puts "-------------------------------------"
  puts "Dealer's Turn!!"
  while calculate_sum(dealer_hand) < 17
    puts "Dealer Hits!"
    dealer_hand << draw_card(deck)
  end

  if calculate_sum(dealer_hand) > 21
    puts "Dealer busts, you win!!"
    calculate_sum(dealer_hand)
  else
    calculate_sum(dealer_hand)
  end
end

def calculate_sum(hand)
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

new_game