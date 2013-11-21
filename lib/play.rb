require 'game'

game = Game.new
game.deal
game.select_best_hands
print "The winner is #{game.winner.name} with a #{game.winner.hand.hand_name}"