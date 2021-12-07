require_relative 'validation.rb'

class CargoWagons < Wagons
  include Validation
  attr_reader :occupied_volume, :total_volume, :available_volume
  validate :total_volume, :presence
  validate :total_volume, :type, Integer

  def initialize(total_volume)
    @total_volume = total_volume
    @available_volume = total_volume
    occupied_volume
    super("грузовой")
  end

  def take_a_volume(volume)
    if volume <= @available_volume
      @available_volume -= volume
      @occupied_volume << volume
      volume
    end
  end

  def occupied_volume
    @occupied_volume = [0] unless @occupied_volume
    @occupied_volume.sum
  end
end