class Route
  attr_reader :station_list, :last_station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @station_list = []
    @station_list << first_station << last_station
  end

  def add_station(station)
    index_last_station = @station_list.index(@last_station)
    @station_list.insert(index_last_station, station)
  end

  def delete_station(station)
    @station_list.delete_if { |s| s == station }
  end

  def all_station
    @station_list.each {|station| puts station}
  end
end