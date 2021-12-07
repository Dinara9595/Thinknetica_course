class Hand
  def initialize
    @cards = []
  end

  def add(card)
    raise StandardError if @cards.count == 3
    @cards << card
  end

  def to_s
    @cards.map.with_index { |card, index| "#{index}: #{card}" }.join("\n")
  end

  def points
    @cards.inject(0) do |sum, card|
      point = card.points.find do |point|
        (sum + point) <= 21
      end || points.first

      sum + point
    end
  end

  def count
    @cards.count
  end
end