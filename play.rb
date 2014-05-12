$: << "./lib"

require "holdem"

game = Holdem.new(2)
game.deal
game.flop
game.turn
game.river
game.judge
puts '', ''
game.players.each do |player|
  print "#{player.name} had a #{player.hand.hand_name} (#{player.hand.cards.join(", ")})\n"
end
#print "\nThe winner is #{game.winner.name} with a #{game.winner.hand.hand_name}\n"