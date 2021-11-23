class Train

  attr_accessor :speed
  attr_reader :station_now, :type, :number, :route, :amount, :station_start

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
    if @speed == 0
      @amount = @amount + num
    else
      puts "Error! You cannot add / subtract train wagons while the train is driving!"
    end
  end

  def add_route(route)
    @route = route
    @station_start = @route.station_list.first
  end

  def forward(route)
    route_station = route.station_list
    start_station = route_station.first
    index = route_station.index(start_station) + 1
    if index <= route_station.size - 1
      route_station[index]
    else
      puts "Train is on the last station of route"
    end
  end

  def backward(route)
    route_station = route.station_list
    start_station = route_station.first
    index = route_station.index(start_station) - 1
    if index > 0
      route_station[index]
    else
      puts "Train has not previous station"
    end
  end

  def station_now(route)
    route.station_list.first
  end

  def station_previous(route)
    station_now = route.station_list.first
    index = route.station_list.index(station_now) - 1
    route[index].name if index > 0
  end

  def station_next(route)
    station_now = route.station_list.first
    index = route.station_list.index(station_now) + 1
    route.station_list[index].name if index <= route.station_list.size - 1
  end
end