class PassengerWagons < Wagons
  def initialize
    super("пассажирский")
  end
end

#валидацию при создании пассажирского вагона не вижу делать смысла так как тип вагона при создании сразу задается