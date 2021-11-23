class Train
  attr_accessor :speed
  attr_reader :type, :number, :amount, :route, :station_start, :current_st

  def initialize(number, type, amount)
    @number = number
    @type = type
    @amount = amount
    @speed = 0
  end

  def go(speed)
    self.speed = speed
  end

  def stop
    @speed = 0
  end

  def amount_wagons(num)
    @amount = @amount + num if @speed == 0
  end

  def add_route(route)
    @route = route
    @current_st = @route.station_list.first
  end

  def forward
    @current_st = next_st if next_st
  end

  def backward
    @current_st = previous_st if previous_st
  end

  def next_st
    index = @route.station_list.index(@current_st) + 1
    @route.station_list[index] if index <= @route.station_list.size - 1
  end

  def previous_st
    index = @route.station_list.index(@current_st) - 1
    @route.station_list[index] if index >= 0
  end
end