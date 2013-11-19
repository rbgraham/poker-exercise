require 'spec_helper'

describe Card do
  let (:card) { Card.new(2, 'Spades') }
  
  describe "ranks" do
    it "should have 13 ranks" do 
      Card::RANKS.count.should == 13
    end
    
    it "should have 2-A mapped to 2-14" do
      Card::RANKS.should == (2..14).to_a
      
      Card::RANK_NAMES[2].should == '2'
      Card::RANK_NAMES[10].should == '10'
      Card::RANK_NAMES[11].should == 'J'
      Card::RANK_NAMES[12].should == 'Q'
      Card::RANK_NAMES[13].should == 'K'
      Card::RANK_NAMES[14].should == 'A'
    end
  end
  
  describe "suits" do
    it "should have 4 suits" do
      Card::SUITS.count.should == 4
    end
    
    it "should have spades, hearts, clubs, and diamonds" do
      Card::SUITS.should == ["Spades", "Clubs", "Hearts", "Diamonds"]
    end
  end
  
  describe "#initialize" do
    it "should require the rank exists in RANKS" do
      expect { Card.new(34, "Spades") }.to raise_error
      expect { Card.new(0, "Spades") }.to raise_error
      expect { Card.new('J', "Spades") }.to raise_error
    end
    
    it "should require the suit exists in SUITS" do
      expect { Card.new(3, "spades") }.to raise_error
      expect { Card.new(3, "Spades1") }.to raise_error
      expect { Card.new(3, 2) }.to raise_error
    end
    
    it "should set the rank and suit" do
      card.rank.should == 2
      card.suit.should == "Spades"
    end
  end
  
  describe "#<=>" do
    it "should prefer X+1 to X" do
      (2..13).to_a.each do |i|
        Card.new(i, "Spades").should < Card.new(i+1, "Diamonds")
      end
    end
    
    it "should say equal ranks are equal" do
      Card.new(2, "Spades").should == Card.new(2, "Diamonds")
      Card.new(12, "Spades").should == Card.new(12, "Diamonds")
    end
  end
end