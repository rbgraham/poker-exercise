require 'spec_helper'

describe Deck do
  let (:deck) { Deck.new }
  
  describe "#shuffle" do
    it "should mix up the cards" do
      cards = deck.cards.map(&:rank)
      deck.shuffle
      deck.cards.should_not == cards
    end
    
    it "should call shuffle!" do
      deck.cards.should_receive(:shuffle!)
      deck.shuffle
    end
  end
  
  describe "#initialize" do
    it "should have 52 cards" do
      deck.cards.count.should == 52
    end
    
    it "should have 13 of each suit" do
      Card::SUITS.each do |suit|
        deck.cards.select {|c| c.suit == suit }.count.should == 13
      end
    end
    
    it "should have 4 suits" do
      deck.cards.map {|c| c.suit }.uniq.count.should == 4
    end
    
    it "should have 4 cards of each rank" do
      Card::RANKS.each do |rank|
        deck.cards.select {|c| c.rank == rank }.count.should == 4
      end
    end
  end
  
  describe "#deal" do
    before do
      @hands = deck.deal(5, 3)
    end
    
    it "should call shuffle" do
      deck.should_receive(:shuffle)
      deck.deal(5, 3)
    end  
    
    it "should return the right number of Hands" do
      @hands.count.should == 3
    end
    
    it "should return the right number of cards per Hand" do
      @hands.first.cards.count.should == 5
    end
    
    it "should return an array of Hands" do
      @hands.first.class.should == Hand
    end
  end
  
  describe "#draw" do
    it "should return a card" do
      card = deck.draw
      card.class.should == Card
    end
    
    it "should return the card on top of the deck" do
      card = deck.cards.first
      deck.draw.should == card
    end
    
    it "should raise an error if the deck is empty" do
      expect { deck.deal(20, 20) }.to raise_error
    end
  end
end