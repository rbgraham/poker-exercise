$: << "./lib"

require "holdem"

$stdout.print "How many players? "
$stdout.flush
choice = $stdin.gets

game = Holdem.new(choice.to_i)
game.play

#print "\nThe winner is #{game.winner.name} with a #{game.winner.hand.hand_name}\n"