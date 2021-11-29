require_relative 'instance_counter.rb'

class Route
  include InstanceCounter
  attr_accessor :station_list, :first_station, :last_station

  class << self
    def all
      @all ||= []
    end
  end

  def initialize(first_station, last_station)
    @station_list = [first_station, last_station]
    self.class.all << self
    register_instance
    validate!
  end

  def validate!
    first_station = @station_list.first
    last_station = @station_list.last
    raise "Переданный объект не является станцией" unless first_station.kind_of? Station and last_station.kind_of? Station
    raise "Первая и вторая станции в маршруте не могут быть одинаковыми" if first_station == last_station
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def add_station(station)
    @station_list.insert(-2, station)
  end

  def delete_station(station)
    @station_list.delete(station)
  end
end