require_relative 'manufacturing_company.rb'
require_relative 'instance_counter.rb'

class Train
  include ManufacturingCompany
  include InstanceCounter

  attr_reader :speed, :type, :number, :route, :station_start, :current_st, :wagons

  NUMBER_FORMAT = /^[а-яa-z\d]{3}[-]*[а-яa-z\d]{2}$/i
  ARRAY_TYPE = %w[пассажирский грузовой]

  class << self
    def all
      @all ||= []
    end
    def find(number)
      train_by_number = @all.select { |train| train.number == number }
      puts train_by_number if train_by_number
    end
  end

  def initialize(number, type)
    @number = number.to_s if number
    @type = type
    @speed = 0
    @wagons = []
    self.class.all << self
    register_instance
    validate!
  end

  def validate!
    raise "Номер не может быть nil" if number.nil?
    raise "Номер должен быть не менее пяти символов" if number.length < 5
    raise "Невалидный формат номера" if number !~ NUMBER_FORMAT
    raise "Неверный ввод! Тип поезда может быть либо грузовой, либо пассажирский" unless ARRAY_TYPE.include?(type)
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def forward
    if next_st
      @current_st = next_st
    else
      @current_st
    end
  end

  def backward
    if previous_st
      @current_st = previous_st
    else
      @current_st
    end
  end

  def next_st
    index = @route.station_list.index(@current_st) + 1
    @route.station_list[index] if index <= @route.station_list.size - 1
  end

  def previous_st
    index = @route.station_list.index(@current_st) - 1
    @route.station_list[index] if index >= 0
  end

  def add_wagon(wagon)
    return puts "Такой вагон уже есть у этого поезда" if @wagons.include?(wagon)
    @wagons << wagon if self.type == wagon.type
  end

  def delete_wagon(wagon)
    @wagons.delete(wagon)
  end

  def add_route(route)
    @route = route
    @current_st = @route.station_list.first
  end

  def wagon_train(&block)
    @wagons.each {|wagon| block.call(wagon)}
  end
  #t.wagon_train {|wagon| puts wagon}

  private

  attr_writer :speed

  def go(speed)
    self.speed = speed
  end

  INITIAL_SPEED = 0

  def stop
    @speed = INITIAL_SPEED
  end
end

