class Train

  attr_accessor :speed, :amount, :station_start
  attr_reader :station_now, :type, :number, :route

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
      @amount = @amount.to_i + num.to_i
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

  def station_info(route)
    #binding.irb
    route_station = route.station_list
    station_info = []
    station_now = route_station.first
    index_previous = route_station.index(station_now) - 1
    if index_previous > 0
      station_previous = route_station[index_previous].name
    else
      station_previous = "no"
    end

    index_next = route_station.index(station_now) + 1
    if index_next <= route_station.size - 1
      station_next = route_station[index_next].name
    else
      station_next = "no"
    end

    station_info << station_previous << station_now.name << station_next
    p station_info
  end
end