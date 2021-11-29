class PassengerTrain < Train
  def initialize(number)
    super(number, "пассажирский")
    validate!
  end

  def validate!
    raise "Номер не может быть nil" if number.nil?
    raise "Номер должен быть не менее пяти символов" if number.length < 5
    raise "Невалидный формат номера" if number !~ NUMBER_FORMAT
  end

  def valid?
    validate!
    true
  rescue
    false
  end
end