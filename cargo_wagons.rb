class CargoWagons < Wagons
  attr_reader :occupied_volume, :total_volume, :available_volume

  def initialize(total_volume)
    @total_volume = total_volume
    @available_volume = total_volume
    occupied_volume
    super("грузовой")
    validate!
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

  def validate!
    raise "Объем вагона не может быть nil" if total_volume.nil?
    raise "Объем вагона не может быть равен 0" if total_volume == 0
    raise "Невалидный формат ввода, объем может быть только в цифрах" unless total_volume.is_a? Integer
  end

  def valid?
    validate!
    true
  rescue
    false
    end
end