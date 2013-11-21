require 'spec_helper'

describe Hand do
  let (:seven_high) { [Card.new(3, "Spades"), Card.new(2, "Spades"), Card.new(7, "Hearts"), Card.new(4, "Diamonds"), Card.new(5, "Spades")] }
  let (:ten_high) { [Card.new(3, "Spades"), Card.new(4, "Spades"), Card.new(5, "Hearts"), Card.new(2, "Diamonds"), Card.new(10, "Spades")] }
  let (:king_high_J) { [Card.new(3, "Spades"), Card.new(4, "Spades"), Card.new(5, "Hearts"), Card.new(11, "Diamonds"), Card.new(13, "Spades")] }
  let (:king_high_10) { [Card.new(3, "Spades"), Card.new(4, "Spades"), Card.new(5, "Hearts"), Card.new(10, "Diamonds"), Card.new(13, "Spades")] }
  let (:ace_high) { [Card.new(3, "Spades"), Card.new(14, "Spades"), Card.new(5, "Hearts"), Card.new(11, "Diamonds"), Card.new(10, "Spades")] }
  
  let (:pair) { [Card.new(3, "Spades"), Card.new(3, "Hearts"), Card.new(5, "Hearts"), Card.new(11, "Diamonds"), Card.new(10, "Spades")] }
  let (:better_pair) { [Card.new(3, "Spades"), Card.new(5, "Spades"), Card.new(5, "Hearts"), Card.new(11, "Diamonds"), Card.new(10, "Spades")] }
  let (:two_pair) { [Card.new(3, "Spades"), Card.new(3, "Hearts"), Card.new(5, "Hearts"), Card.new(5, "Diamonds"), Card.new(10, "Spades")] }
  let (:better_two_pair) { [Card.new(4, "Spades"), Card.new(4, "Hearts"), Card.new(5, "Hearts"), Card.new(5, "Diamonds"), Card.new(10, "Spades")] }
  let (:best_two_pair) { [Card.new(3, "Spades"), Card.new(3, "Hearts"), Card.new(10, "Hearts"), Card.new(5, "Diamonds"), Card.new(10, "Spades")] }
  let (:set) { [Card.new(3, "Spades"), Card.new(3, "Diamonds"), Card.new(3, "Hearts"), Card.new(11, "Diamonds"), Card.new(10, "Spades")] }
  let (:flush) { [Card.new(3, "Spades"), Card.new(4, "Spades"), Card.new(5, "Spades"), Card.new(11, "Spades"), Card.new(10, "Spades")] }
  let (:straight) { [Card.new(3, "Spades"), Card.new(4, "Hearts"), Card.new(5, "Hearts"), Card.new(6, "Diamonds"), Card.new(7, "Spades")] }
  let (:full_house) { [Card.new(3, "Spades"), Card.new(3, "Hearts"), Card.new(3, "Diamonds"), Card.new(11, "Diamonds"), Card.new(11, "Spades")] }
  let (:four_of_a_kind) { [Card.new(3, "Spades"), Card.new(3, "Hearts"), Card.new(3, "Diamonds"), Card.new(3, "Clubs"), Card.new(10, "Spades")] }
  let (:straight_flush) { [Card.new(3, "Spades"), Card.new(4, "Spades"), Card.new(5, "Spades"), Card.new(6, "Spades"), Card.new(7, "Spades")] }
  
  let (:bad_hand) { [Card.new(3, "Spades"), Card.new(3, "Spades"), Card.new(5, "Hearts"), Card.new(5, "Diamonds"), Card.new(10, "Spades")] }
  
  let (:hand) { Hand.new(pair) }
  
  describe "#pair?" do
    describe "when we have a pair" do
      it "should say we do" do
        hand.send(:pair?).should be_true
      end
    end
    
    describe "when we don't have a pair" do
      it "should say we don't" do
        hand = Hand.new(king_high_J)
        hand.send(:pair?).should be_false
      end
    end
  end
  
  describe "#two_pair?" do
    describe "when we have two pair" do
      it "should say we do" do
        hand = Hand.new(two_pair)
        hand.send(:two_pair?).should be_true
      end
    end
    
    describe "when we don't have two pair" do
      it "should say we don't" do
        hand.send(:two_pair?).should be_false
      end
    end
  end
  
  describe "#set?" do
    describe "when we have a set" do
      it "should say we do" do
        hand = Hand.new(set)
        hand.send(:set?).should be_true
      end
    end
    
    describe "when we don't have a set" do
      it "should say we don't" do
        hand.send(:set?).should be_false
      end
    end
  end
  
  describe "#flush?" do
    describe "when we have a flush" do
      it "should say we do" do
        hand = Hand.new(flush)
        hand.send(:flush?).should be_true
      end
    end
    
    describe "when we don't have a flush" do
      it "should say we don't" do
        hand.send(:flush?).should be_false
      end
    end
  end
  
  describe "#straight?" do
    describe "when we have a straight" do
      it "should say we do" do
        hand = Hand.new(straight)
        hand.send(:straight?).should be_true
      end
    end
    
    describe "when we don't have a straight" do
      it "should say we don't" do
        hand.send(:straight?).should be_false
      end
    end
  end
  
  describe "#full_house?" do
    describe "when we have a full_house" do
      it "should say we do" do
        hand = Hand.new(full_house)
        hand.send(:full_house?).should be_true
      end
    end
    
    describe "when we don't have a full_house" do
      it "should say we don't" do
        hand.send(:full_house?).should be_false
      end
    end
  end
  
  describe "#four_of_a_kind?" do
    describe "when we have a four_of_a_kind" do
      it "should say we do" do
        hand = Hand.new(four_of_a_kind)
        hand.send(:four_of_a_kind?).should be_true
      end
    end
    
    describe "when we don't have a four_of_a_kind" do
      it "should say we don't" do
        hand.send(:four_of_a_kind?).should be_false
      end
    end
  end
  
  describe "#straight_flush?" do
    describe "when we have a straight flush" do
      it "should say we do" do
        hand = Hand.new(straight_flush)
        hand.send(:straight_flush?).should be_true
      end
    end
    
    describe "when we don't have a straight flush" do
      it "should say we don't" do
        hand.send(:straight_flush?).should be_false
      end
    end
  end
  
  describe "nothing hand" do
    describe "when we have nothing" do
      it "should say we do" do
        hand = Hand.new(ten_high)
        hand.hand_name.should == "nothing"
      end
    end

    describe "when we don't have nothing" do
      it "should say we don't" do
        hand.hand_name.should_not == "nothing"
      end
    end
  end
  
  describe "#<=>" do
    describe "when we have hands of different value" do
      it "should prefer a pair to nothing" do
        Hand.new(pair).should > Hand.new(ten_high)
      end
      
      it "should prefer two pair to a pair" do
        Hand.new(two_pair).should > Hand.new(pair)
      end
      
      it "should prefer a set to two pair" do
        Hand.new(set).should > Hand.new(two_pair)
      end
      
      it "should prefer a straight to a set" do
        Hand.new(straight).should > Hand.new(set)
      end
      
      it "should prefer a flush to a straight" do
        Hand.new(flush).should > Hand.new(straight)
      end
      
      it "should prefer a full house to a flush" do
        Hand.new(full_house).should > Hand.new(flush)
      end
      
      it "should prefer four of a kind to a full house" do
        Hand.new(four_of_a_kind).should > Hand.new(full_house)
      end
      
      it "should prefer a straight flush to four of a kind" do
        Hand.new(straight_flush).should > Hand.new(four_of_a_kind)
      end
      
      it "should prefer a flush to a pair" do
        Hand.new(flush).should > Hand.new(pair)
      end
      
      it "should prefer a flush to nothing" do
        Hand.new(flush).should > Hand.new(ten_high)
      end
      
      it "should prefer a straight to two pair" do
        Hand.new(straight).should > Hand.new(two_pair)
      end
      
      it "should prefer a full house to a set" do
        Hand.new(full_house).should > Hand.new(set)
      end
    end
    
    describe "when we have hands of equal value" do
      describe "pair" do
        describe "when the pair is of unequal value" do
          it "should prefer the higher rank pair" do
            Hand.new(pair).should < Hand.new(better_pair)
          end
        end
        
        describe "when the pair is of equal value" do
          it "should prefer the higher rank kicker" do
            other_pair = pair.dup
            other_pair[-2] = Card.new(6, "Diamonds")
            hand.should > Hand.new(other_pair)
          end
          
          it "should prefer the higher rank nth kicker if the first are equal" do
            other_pair = pair.dup
            other_pair[-1] = Card.new(9, "Diamonds")
            hand.should > Hand.new(other_pair)
          end
          
          it "should split on equal kickers" do
            hand.should == Hand.new(pair)
          end
        end
      end
      
      describe "nothing" do
          it "should prefer the higher rank nth kicker if the first are equal" do
            Hand.new(seven_high).should < Hand.new(ten_high)
            Hand.new(king_high_J).should > Hand.new(king_high_10)
            Hand.new(ace_high).should > Hand.new(king_high_J)
          end
          
          it "should split on equal kickers" do
            Hand.new(seven_high).should == Hand.new(seven_high)
            Hand.new(ace_high).should == Hand.new(ace_high)
          end
      end
      
      describe "two pair" do
        describe "when the top pair is of unequal value" do
          it "should prefer the higher rank pair" do
            Hand.new(two_pair).should < Hand.new(better_two_pair)
          end
        end
        
        describe "when the pair is of equal value" do
          it "should prefer the higher rank kicker" do
            other_pair = two_pair.dup
            other_pair[-1] = Card.new(6, "Diamonds")
            Hand.new(two_pair).should > Hand.new(other_pair)
          end
          
          it "should split on equal kickers" do
            Hand.new(two_pair).<=>(Hand.new(two_pair)).should == 0
            Hand.new(better_two_pair).should == Hand.new(better_two_pair)
          end
        end
      end
      
      describe "flush" do
        it "should prefer the higher rank nth kicker if the first are equal" do
          other = flush.dup
          other.sort
          other[-1] = Card.new(14, "Spades")
          Hand.new(other).should > Hand.new(flush)
        end
        
        it "should split on equal kickers" do
          Hand.new(flush).should == Hand.new(flush)
        end
      end
      
      describe "set" do
        describe "when the set is of unequal value" do
          it "should prefer the higher rank set" do
            better_set = better_pair.dup
            better_set[0] = Card.new(5, "Clubs")
            Hand.new(set).should < Hand.new(better_set)
          end
        end
        
        describe "when the set is of equal value" do
          it "should prefer the higher rank kicker" do
            other_set = set.dup
            other_set[-2] = Card.new(6, "Diamonds")
            Hand.new(set).should > Hand.new(other_set)
          end
          
          it "should prefer the higher rank nth kicker if the first are equal" do
            other_set = set.dup
            other_set[-1] = Card.new(6, "Diamonds")
            Hand.new(set).should > Hand.new(other_set)
          end
          
          it "should split on equal kickers" do
            Hand.new(set).should == Hand.new(set)
          end
        end
      end
      
      describe "four of a kind" do
        describe "when the quad is of unequal value" do
          it "should prefer the higher rank quad" do
            better_quad = four_of_a_kind.dup
            better_quad[0] = Card.new(14, "Clubs")
            better_quad[1] = Card.new(14, "Diamonds")
            better_quad[2] = Card.new(14, "Hearts")
            better_quad[3] = Card.new(14, "Spades")
            Hand.new(four_of_a_kind).should < Hand.new(better_quad)
          end
        end
        
        describe "when the quad is of equal value" do
          it "should prefer the higher rank kicker" do
            quad = four_of_a_kind.dup
            quad[-1] = Card.new(2, "Diamonds")
            Hand.new(four_of_a_kind).should > Hand.new(quad)
          end
          
          it "should split on equal kickers" do
            Hand.new(four_of_a_kind).should == Hand.new(four_of_a_kind)
          end
        end
      end
      
      describe "straight" do
        describe "when the straights are unequal" do
          it "should pick the high card straight" do
            better = straight.dup.map {|c| Card.new(c.rank + 1, c.suit) }
            Hand.new(straight).should < Hand.new(better)
          end
        end
        
        describe "when the straights are equal" do
          it "should split" do
            Hand.new(straight).should == Hand.new(straight)
          end
        end
      end
      
      describe "flush" do
        describe "when the flushes are unequal" do
          it "should pick the high card flush" do
            better = flush.dup.map {|c| Card.new(c.rank + 1, c.suit) }
            Hand.new(flush).should < Hand.new(better)
          end
        end
        
        describe "when the straights are equal" do
          it "should split" do
            Hand.new(flush).should == Hand.new(flush)
          end
        end
      end
      
      describe "full house" do
        describe "when the full house is of unequal value" do
          it "should prefer the higher rank full house" do
            better_house = full_house.dup
            better_house[0] = Card.new(14, "Clubs")
            better_house[1] = Card.new(14, "Diamonds")
            better_house[2] = Card.new(14, "Hearts")
            Hand.new(better_house).should > Hand.new(full_house)
          end
        end
        
        describe "when the full house is of equal value" do
          it "should prefer the higher rank pair" do
            house = full_house.dup
            house[-1] = Card.new(2, "Diamonds")
            house[-2] = Card.new(2, "Spades")
            Hand.new(house).should < Hand.new(full_house)
          end
          
          it "should split on equal pairs" do
            Hand.new(full_house).should == Hand.new(full_house)
          end
        end
      end
      
      describe "straight flush" do
        describe "when the straight flushes are unequal" do
          it "should pick the high card straight flush" do
            better = straight_flush.dup.map {|c| Card.new(c.rank + 1, c.suit) }
            Hand.new(straight_flush).should < Hand.new(better)
          end
        end
        
        describe "when the straight flushes are equal" do
          it "should split" do
            Hand.new(straight_flush).should == Hand.new(straight_flush)
          end
        end
      end
    end
  end

  describe "#pairs" do
    describe "when we have a pair" do
      it "should return the pair" do
        hand.pairs.count.should == 1
        hand.pairs.should == [[Card.new(3, "Spades"), Card.new(3, "Hearts")]]
      end
    end
    
    describe "when we have two pair" do
      it "should return the pairs" do
        hand = Hand.new(two_pair)
        hand.pairs.count.should == 2
        hand.pairs.map {|p| p.map(&:rank) }.should == [[3,3], [5,5]]
      end
    end
    
    describe "when we have a full house" do
      it "should return the pair" do
        hand = Hand.new(full_house)
        hand.pairs.count.should == 1
        hand.pairs.first.map(&:rank).should == [11, 11]
      end
    end
    
    describe "when we have nothing" do
      it "should return empty list" do
        Hand.new(seven_high).pairs.empty?.should be_true
      end
    end
  end
  
  describe "#set" do
    describe "when we have a pair" do
      it "should return empty list" do
        hand.set.empty?.should be_true
      end
    end
    
    describe "when we have two pair" do
      it "should return empty list" do
        hand = Hand.new(two_pair)
        hand.set.empty?.should be_true
      end
    end
    
    describe "when we have a full house" do
      it "should return the set" do
        hand = Hand.new(full_house)
        hand.set.count.should == 3
        hand.set.map(&:rank).should == [3, 3, 3]
      end
    end
    
    describe "when we have a set" do
      it "should return the set" do
        hand = Hand.new(set)
        hand.set.count.should == 3
        hand.set.map(&:rank).should == [3, 3, 3]
      end
    end
    
    describe "when we have nothing" do
      it "should return empty list" do
        Hand.new(seven_high).set.empty?.should be_true
      end
    end
  end
  
  describe "#quads" do
    describe "when we have a pair" do
      it "should return empty list" do
        hand.quads.empty?.should be_true
      end
    end
    
    describe "when we have two pair" do
      it "should return empty list" do
        hand = Hand.new(two_pair)
        hand.quads.empty?.should be_true
      end
    end
    
    describe "when we have quads" do
      it "should return the quads" do
        hand = Hand.new(four_of_a_kind)
        hand.quads.count.should == 4
        hand.quads.map(&:rank).should == [3, 3, 3, 3]
      end
    end
    
    describe "when we have nothing" do
      it "should return empty list" do
        Hand.new(seven_high).quads.empty?.should be_true
      end
    end
  end
end
