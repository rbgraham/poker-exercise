$: << "./lib"

require "game"

game = Game.new
game.deal
game.select_best_hands
game.players.each do |player|
  print "#{player.name} has a #{player.hand.hand_name} (#{player.hand.cards.join(", ")})\n"
end
print "\nThe winner is #{game.winner.name} with a #{game.winner.hand.hand_name}\n"