require_relative 'validation.rb'

class PassengerTrain < Train
  include Validation

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def initialize(number)
    super(number, "пассажирский")
  end
end