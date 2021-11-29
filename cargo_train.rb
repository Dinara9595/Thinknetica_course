class CargoTrain < Train
  NUMBER_FORMAT = /^[а-яa-z\d]{3}[-]*[а-яa-z\d]{2}$/i
  def initialize(number)
    super(number, "грузовой")
    validate!
  end
end