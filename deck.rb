require "card"
require 'hand'

class Deck
  attr_accessor :cards
  attr_reader :top

  def initialize
    @cards = []
    Card::RANKS.each do |r|
      Card::SUITS.each do |s|
        cards.push(Card.new(r, s))
      end
    end
  end

  def shuffle
    @cards.shuffle!
  end

  def deal(cards, players)
    shuffle
    hands = (1..players).to_a.map {|p| (1..cards).to_a.map {|c| draw } }
    hands.map {|h| Hand.new(h) }
  end

  def draw
    raise "there are no more cards in the deck" if @cards.length === 0

    return @cards.shift
  end
end