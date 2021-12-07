class Player
  attr_reader :money
  attr_accessor :hand

  def initialize(money = 100)
    @money = money
  end

  def dawn_balance(money)
    @money -= money
  end

  def up_balance(money)
    @money += money
  end
end