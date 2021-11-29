require_relative 'instance_counter.rb'

class Route
  include InstanceCounter
  attr_reader :station_list

  class << self
    def all
      @all ||= []
    end
  end

  def initialize(first_station, last_station)
    @station_list = [first_station, last_station]
    self.class.all << self
    register_instance
  end

  def add_station(station)
    @station_list.insert(-2, station)
  end

  def delete_station(station)
    @station_list.delete(station)
  end
end