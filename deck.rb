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
    @top = 0
  end
  
  def shuffle
    @cards.shuffle!
    @top = 0
  end
  
  def deal(cards, players)
    shuffle
    hands = (1..players).to_a.map {|p| (1..cards).to_a.map {|c| draw } }
    hands.map {|h| Hand.new(h) }
  end
  
  def draw
    @top += 1
    return @cards[@top-1]
  end
end