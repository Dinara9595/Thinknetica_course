class CargoWagons < Wagons
  def initialize
    super("грузовой")
  end
end
#валидацию при создании грузового вагона не вижу делать смысла так как тип вагона при создании сразу задается