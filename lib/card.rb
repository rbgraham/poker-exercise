class Card
  include Comparable
  RANKS = (2..14).to_a
  SUITS = ["Spades", "Clubs", "Hearts", "Diamonds"]

  RANK_NAMES = {
    2 => "2",
    3 => "3",
    4 => "4",
    5 => "5",
    6 => "6",
    7 => "7",
    8 => "8",
    9 => "9",
    10 => "10",
    11 => "J",
    12 => "Q",
    13 => "K",
    14 => "A",
  }

  attr_accessor :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    return "#{RANK_NAMES[rank]} of #{suit}"
  end

  def dup
    return Card.new(rank, suit)
  end

  def eql?(other)
    self.to_s == other.to_s
  end

  def <=>(other)
  end
end