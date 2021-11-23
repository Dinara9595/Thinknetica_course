class Station

  #attr_accessor :train_now
  attr_reader :name, :train_now

  def initialize(name)
    @name = name
    @train_now = []
  end

  def add_train(train)
    @train_now << train
  end


  def trains_by(type)
    @train_now.select { |train| train.type == type }
  end

  def send_of_train(train)
    @train_now.delete(train)
  end
end