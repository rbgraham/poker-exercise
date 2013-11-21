require_relative 'deck'
require 'ostruct'

class Game
  attr_reader :players

  def initialize
    $stdout.print "Enter the number of players: "
    $stdout.flush
    number_of_players = $stdin.gets.chomp.to_i

    raise "invalid number of players" if number_of_players <= 0 or number_of_players > 8

    @players = (1..number_of_players).collect do |i|
      OpenStruct.new(player: i, hand: nil, name: "Player #{i}")
    end
  end

  def deal
    deck = Deck.new
    @players.each do |player|
      player.hand = deck.deal(7, 1).first
    end
  end

  def select_best_hands
    @players.each do |player|
      hand = player.hand

      combinations = hand.cards.combination(5).to_a.collect do |c|
        Hand.new(c)
      end

      player.hand = combinations.max
    end
  end

  def winner
    @players.max { |a, b| a.hand <=> b.hand }
  end
end