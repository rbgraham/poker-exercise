require 'ostruct'
require 'deck'
require 'player'
require 'set'

class Holdem
  attr_accessor :players, :hands, :blind, :button, :current_players, :pot, :current_bet, :stage, :folded, :community
  
  PREFLOP = 1
  TURN = 2
  RIVER = 3
  FINAL = 4

  # TODO side pots  
  # TODO putting other ai players past all in results in a fold
  # TODO hand success predictions, show possible hands
  # TODO improved ai
  # TODO handle winning a game and starting a new one, if desired
  
  def initialize(players, blind = 100)
    @deck = Deck.new
    @blind = blind
    
    raise "invalid number of players" if players < 2 or players > 8

    @players = (1..players).collect do |i|
      Player.new("AI Player #{i}", true, 10000) 
    end
    @players.push(Player.new("You", false, 10000))
    
    @button = 0
    @stage = PREFLOP
    @folded = []
    @pot = 0
    @community = Hand.new([])
  end
  
  def play
    while true
      puts "\nCtrl-C to leave the table."
      
      self.deal
      self.flop
      self.turn
      self.river
      self.judge
    end
  end
  
  def bets_equal?
    puts "", "BETS", "#{@current_players.map(&:current_bet).join(', ')}", "#{Set.new(@current_players.map(&:current_bet)).to_a}", ""
    Set.new(@current_players.map(&:current_bet)).to_a.count == 1
  end
  
  def bets
    # order via the button
    @current_bet = 0
    @folded = []
    
    bet_loop
    until self.bets_equal?
      puts "", "Bets unequal...#{@current_players.map(&:current_bet).join(', ')}"
      bet_loop
    end

    total_the_pot
    clear_players_bets
  end
  
  def bet_loop
    @current_players.each do |player|
      bet = player.decide(@stage == PREFLOP, @blind, @current_bet, pot_peek, @community)
      if bet == Player::FOLD
        @folded.push(player)
      else
        @current_bet = bet
      end
    end
    @current_players.delete_if {|p| @folded.include?(p) }
  end
    
  def pot_peek
    @pot + @players.map(&:current_bet).compact.inject(&:+)
  end
    
  def total_the_pot
    @pot += @players.map(&:current_bet).compact.inject(&:+)
  end
    
  def clear_players_bets
    @players.each do |player|
      player.clear_bet
    end
  end
  
  def deal
    @deck.shuffle
    
    @players.each do |player|
      player.hand = @deck.deal(2, 1).first
    end
    
    if @button == (@players.count - 1)
      @button = 0
    else
      @button += 1
    end
    
    @current_players = @players.dup
    @stage = PREFLOP
    bets
  end
  
  def flop
    cards = [@deck.draw, @deck.draw, @deck.draw]
    @community.cards += cards
    puts "", "The flop comes out #{cards}.", ""
    @stage = TURN
    bets
  end
  
  def turn
    card = @deck.draw
    @community.cards += [card]
    puts "", "The turn is #{card}.", ""
    @stage = RIVER
    bets
  end
  
  def river
    card = @deck.draw
    @community.cards += [card]
    puts "", "The river is #{card}.", ""
    @stage = FINAL
    bets
  end
  
  def judge
    @players.each do |player|
      player.hand.cards += @community.cards
    end
    winner = @current_players.max { |a, b| a.hand <=> b.hand }
    winner.give_chips(@pot)
    
    puts "========================================================================================================="
    puts "", "THE WINNER IS", "#{winner.name} -- #{winner.hand.hand_name}. Pot was #{@pot}.", ""
    @players.each do |player|
      puts "#{player.name} =>\t#{player.chips}."
    end
    puts "========================================================================================================="
    setup
  end
  
  def setup
    @deck.setup
    @players.map {|p| p.clear_bet }
    @folded = []
    
    busted = []
    @players.each do |player|
      if player.chips < @blind
        busted.push(player) 
        puts "#{player.name} busted out."
      end
    end
    @players.delete_if {|p| busted.include?(p) }
    
    @stage = PREFLOP
    @pot = 0
    @community = Hand.new([])
    # TODO rotate the players array and keep the "button" always on top
  end
end