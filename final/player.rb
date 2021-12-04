class Player
  attr_reader :name, :cards
  attr_accessor :money
  def initialize(cards, name, money = 100)
    @money = money
    @name = name
    @cards = cards
  end
end