require_relative 'validation.rb'

class CargoTrain < Train
  include Validation
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def initialize(number)
    super(number, "грузовой")
  end
end