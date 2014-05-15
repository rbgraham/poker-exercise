class Player
  attr_accessor :chips, :hand, :name
  attr_reader :ai, :current_bet
  
  FOLD = -1
  CHECK = 0
  
  def initialize(name, ai, chips)
    @name = name
    @chips = chips ? chips : 10000
    @ai = ai.nil? ? true : ai
    @current_bet = 0
  end
  
  def decide(preflop, blind, current_bet, pot, cards)
    if current_bet == @current_bet && current_bet > 0
      return 0
    end
    
    if @ai
      ai_decide(preflop, blind, current_bet, pot, cards)
    else
      show_state(preflop, blind, current_bet, pot, cards)
      human_decide(preflop, blind, current_bet, pot, cards)
    end
  end
  
  def show_state(preflop, blind, current_bet, pot, cards)
    puts ""
    puts "You must bet at least #{current_bet - @current_bet} or match the blind (#{blind})."
    puts "Pot: #{pot}."
    puts "Chips: #{@chips}."
    puts "Community Cards: #{cards.cards}" unless preflop
    puts "Your Cards: #{@hand.cards}"
    all_cards = @hand.cards
    all_cards += cards.cards unless preflop
    puts "Right now you have [a] #{Hand.new(all_cards).hand_name}."
    puts ""
  end
  
  def clear_bet
    @current_bet = 0
  end
  
  def give_chips(amount)
    @chips += amount
  end
  
  private
  
  def human_decide(preflop, blind, current_bet, pot, cards)
    if current_bet == @current_bet
      bet(0)
    end
    
    $stdout.print "Enter an amount to bet, enter to check, or [f]old: "
    $stdout.flush
    choice = $stdin.gets.strip

    if choice.start_with?('f')
      fold
    elsif choice.nil? || (choice == '')
      check(preflop, blind)
    else
      bet(choice.to_i)
    end
  end
  
  def ai_decide(preflop, blind, current_bet, pot, cards)
    if (current_bet == 0) && preflop
      puts "Player #{@name} is betting..."
      bet(blind)
    elsif (current_bet == 0) && !preflop
      puts "Player #{@name} is checking..."
      check(preflop, blind) # check!
    elsif current_bet <= (@chips + @current_bet)
      puts "Player #{@name} is calling..."
      bet(current_bet - @current_bet)
    else
      puts "Player #{@name} folds..."
      fold
    end
  end

  def bet(amount)
    raise Error("You don't have enough chips.") if @chips < amount
    @current_bet += amount
    @chips -= amount
    puts "Player #{@name} bet #{amount} and has #{@chips} remaining." unless amount == 0
    @current_bet
  end
  
  def check(preflop, blind)
    if preflop && current_bet < blind
      puts "You must bet at least the blinds. Your bet is adjusted to the blind."
      bet(blind - @current_bet)
    else
      bet(CHECK)
    end
  end
  
  def fold
    return FOLD
  end
end