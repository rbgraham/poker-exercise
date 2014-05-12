require 'ostruct'
require 'deck'

class Holdem
  attr_accessor :players, :hands, :blind, :button, :current_players
  
  def initialize(players, blind = 100)
    @deck = Deck.new
    @blind = blind
    
    raise "invalid number of players" if players < 2 or players > 8

    @players = (1..players).collect do |i|
      OpenStruct.new(player: i, hand: nil, name: "AI Player #{i}", chips: 10000, bet: 0) 
    end
    @players[0].name = 'You'
    
    @button = 0
  end
  
  def you
    @players[0]
  end
  
  def bets
    $stdout.print "Enter an amount to bet, enter to check, or [f]old: "
    $stdout.flush
    choice = $stdin.gets
    puts choice
    
    if choice.start_with?('f')
      puts "Folding..."
      @current_players.delete(you)
    elsif choice.nil?
      puts "Checking..."
      you.bet += @blind
      puts "#{you.name} bets #{you.bet}."
    else
      bet = choice.to_i
      puts "Betting..."
      you.bet += bet
      puts "#{you.name} bets #{you.bet}."
    end
    
    if @current_players.count == 1
      return judge
    end
    
    @players.slice(1,9).each do |player|
      if you.bet > @blind
        player.bet += you.bet
      else
        player.bet += blind
      end
      puts "#{player.name} bets #{player.bet}."
    end
  end
    
  
  def deal
    @deck.shuffle
    
    @players.each do |player|
      player.hand = @deck.deal(2, 1).first
    end
    puts "You were dealt #{@players[0].hand.cards}.\n"
    
    if @button == (@players.count - 1)
      @button = 0
    else
      @button += 1
    end
    
    @current_players = @players.dup
    bets
  end
  
  def flop
    cards = [@deck.draw, @deck.draw, @deck.draw]
    puts "The flop comes out #{cards}."
    @players.each do |player|
      player.hand.cards += cards
    end
  end
  
  def turn
    card = @deck.draw
    puts "The turn is #{card}."
    @players.each do |player|
      player.hand.cards += [card]
    end
  end
  
  def river
    card = @deck.draw
    puts "The river is #{card}."
    @players.each do |player|
      player.hand.cards += [card]
    end
  end
  
  def judge
    winner = @current_players.max { |a, b| a.hand <=> b.hand }
    @players.each do |player|
      player.chips -= player.bet
    end
    winner.chips += @players.map(&:bet).inject(&:+)
    puts "#{winner.name} -- #{winner.hand.hand_name}. Pot was #{@players.map(&:bet).inject(&:+)}.\n#{winner.name} -- #{winner.chips}."
    setup
  end
  
  def setup
    @deck.setup
    @players.map {|p| p.bet = 0 }
    
    (0..@players.count-1).to_a.each do |i|
      if @players[i].chips < @blind
        p = @players.delete_at(i) 
        puts "#{p.name} busted out."
      end
    end
  end
end