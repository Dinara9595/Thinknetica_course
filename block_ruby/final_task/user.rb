class User < Player
  attr_reader :name

  def initialize(name)
    @name = name
    super(100)
  end
end