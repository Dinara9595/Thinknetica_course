class Station

  attr_accessor :train, :train_now
  attr_reader :name

  def initialize(name)
    @name = name
    @train_now = []
  end

  def add_trains(train)
    @train_now << train
  end

  def list_train_number
    list_train_number = []
    @train_now.each do |train|
      list_train_number << train.number
    end
    p list_train_number
  end

  def list_train_type
    list_train_type = []
    @train_now.each do |train|
      list_train_type << train.type
    end
    p list_train_type
  end

  def type_train(type)
    @type_train = []
    @train_now.each do |train|
      if train.type == type
        @type_train << type
      end
    end
    puts @type_train.size
  end

  def send_of_train(train)
    if @train_now == nil or @train_now.size == 0
      puts "This station has not trains"
    else
      @train_now.delete_if { |t| t == train }
      puts "The #{train} left the station "
    end
  end
end