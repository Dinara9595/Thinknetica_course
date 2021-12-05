class Card
  attr_reader :suit, :rank

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end

  def to_s
    "#{suit}/#{rank}"
  end

  def points
    # Если @rank это буква, то при to_i вернется 0, в противном случае вернется то же число, что и символ ("6".to_i = 6)
    return [@rank.to_i] if @rank.to_i != 0
    # Если @rank это туз, то возвращаем его варианты очков
    return [1, 11] if @rank == 'A'
    # Возвращаем [10], потому что остались только J Q K
    [10]
  end
end
