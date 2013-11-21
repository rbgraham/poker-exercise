require 'card'

class Hand
  include Comparable
  attr_accessor :cards

  HANDS = [
    "nothing", "pair", "two pair", "set", "straight", "flush", "full house", "four of a kind", "straight flush"
    ]

  def initialize(cards)
    @cards = cards
    validate
  end

  def validate
    cards = @cards.collect(&:to_s)
    raise "Can't have two of the same card." if cards.uniq.sort != cards.sort
  end

  def hand
    if straight_flush?
      return HANDS.index("straight flush")
    elsif four_of_a_kind?
      return HANDS.index("four of a kind")
    elsif full_house?
      return HANDS.index("full house")
    elsif flush?
      return HANDS.index("flush")
    elsif straight?
      return HANDS.index("straight")
    elsif set?
      return HANDS.index("set")
    elsif two_pair?
      return HANDS.index("two pair")
    elsif pair?
      return HANDS.index("pair")
    else
      return HANDS.index("nothing")
    end
  end

  def hand_name
    HANDS[hand]
  end

  def kickers
    return buckets.select {|arr| arr.count == 1}.inject(&:+).sort.reverse unless buckets.select {|arr| arr.count == 1}.empty?
    []
  end

  def pairs
    return buckets.select {|arr| arr.count == 2} unless buckets.select {|arr| arr.count == 2}.empty?
    []
  end

  def set
    return buckets.select {|arr| arr.count == 3}.first unless buckets.select {|arr| arr.count == 3}.empty?
    []
  end

  def quads
    return buckets.select {|arr| arr.count == 4}.first unless buckets.select {|arr| arr.count == 4}.empty?
    []
  end

  def <=>(other)
  end

  def buckets
    (2..14).to_a.map do |x|
      @cards.select do |c|
        c.rank == x
      end
    end
  end

  def pair?
    buckets.map(&:count).select {|x| x > 1}.count == 1
  end

  def two_pair?
    buckets.map(&:count).select {|x| x > 1}.count == 2
  end

  def set?
    buckets.map(&:count).select {|x| x == 3}.count == 1
  end

  def four_of_a_kind?
    buckets.map(&:count).select {|x| x == 4}.count == 1
  end

  def straight?
    buckets.map(&:count).join('').include?('11111') or (buckets.map(&:count).join('').start_with?('1111') and buckets.map(&:count)[-1] == 1)
  end

  def flush?
    c = @cards[0]
    @cards.each do |other|
      if c.suit != other.suit
        return false
      end
    end
    true
  end

  def full_house?
    two_pair? and set?
  end

  def straight_flush?
    straight? and flush?
  end
end
