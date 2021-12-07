class Deck
  RANKS = (2..10).to_a + %w[J Q K A]
  SUITS = %w[♥ ♦ ♣ ♠]

  def initialize
    @cards = Deck.build_cards
  end

  def self.build_cards
    cards = []

    SUITS.each do |suit|
      RANKS.each { |rank| cards << Card.new(suit, rank) }
    end

    cards.shuffle
  end

  def pick_up
    @cards.shift
  end
end