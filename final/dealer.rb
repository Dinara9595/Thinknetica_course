class Dealer < Player
  attr_reader :name

  def initialize
    @name = "Дилер"
    super
  end
end