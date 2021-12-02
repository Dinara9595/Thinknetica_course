require_relative 'instance_counter.rb'
require_relative 'accessors.rb'
require_relative 'validation.rb'

class Route
  include InstanceCounter
  include Validation
  extend Accessors

  strong_attr_accessor :first_station, Station
  strong_attr_accessor :last_station, Station
  history :route
  attr_accessor_with_history :route

  validate :first_station, :presence
  validate :last_station, :presence
  validate :first_station, :type, Station
  validate :last_station, :type, Station

  attr_accessor :station_list, :first_station, :last_station

  class << self
    def all
      @all ||= []
    end
  end

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @station_list = [first_station, last_station]
    self.class.all << self
    validate!
    register_instance
  end

  def add_station(station)
    @station_list.insert(-2, station)
  end

  def delete_station(station)
    @station_list.delete(station)
  end
end