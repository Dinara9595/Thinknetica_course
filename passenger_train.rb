class PassengerTrain < Train
  def initialize(number)
    super(number, "пассажирский")
    validate!
  end
end