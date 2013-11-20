require "spec_helper"

describe Game do
  let(:game) { Game.new }
  let (:possible_hands) { [Card.new(3, "Spades"), Card.new(3, "Hearts"), Card.new(3, "Diamonds"), Card.new(11, "Diamonds"), Card.new(11, "Spades"), Card.new(11, "Hearts"), Card.new(12, "Clubs")] }

  before do
    $stdout.stub(:print)
    $stdin.stub(:gets).and_return("5")
  end

  context "setting up" do
    it "should set the number of players" do
      game.players.length.should == 5
    end

    it "raises an error with an invalid number of players" do
      $stdin.stub(:gets).and_return("17")
      expect { game }.to raise_error
    end
  end

  context "#deal" do
    it "creates hands for each player" do
      game.deal
      game.players.first.hand.cards.length.should == 7
    end
  end

  context "#best_hands" do
    it "chooses the best 5-card hand for each player" do
      $stdin.stub(:gets).and_return("1")

      game.deal
      game.players.first.hand.cards = possible_hands
      game.select_best_hands
      game.players.first.hand.hand_name.should == "full house"
    end
  end

  context "#winner" do
    let (:hand_one) { [Card.new(3, "Spades"), Card.new(3, "Hearts"), Card.new(3, "Diamonds"), Card.new(11, "Diamonds"), Card.new(11, "Spades"), Card.new(11, "Hearts"), Card.new(12, "Clubs")] }
    let (:hand_two) { [Card.new(3, "Spades"), Card.new(3, "Hearts"), Card.new(3, "Diamonds"), Card.new(11, "Diamonds"), Card.new(11, "Spades"), Card.new(11, "Hearts"), Card.new(11, "Clubs")] }

    it "chooses the player with the best hand" do
      $stdin.stub(:gets).and_return("2")

      game.deal
      game.players.first.hand.cards = hand_one
      game.players.last.hand.cards = hand_two
      game.winner.should == game.players.last
    end
  end
end