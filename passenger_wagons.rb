class PassengerWagons < Wagons
  attr_reader :total_seats, :occupied_seats, :available_seats

  def initialize(total_seats)
    @total_seats = total_seats
    @available_seats = total_seats
    occupied_seats
    super("пассажирский")
    validate!
  end

  def take_a_seat(seat = 1)
    if seat <= @available_seats
      @available_seats -= seat
      @occupied_seats << seat
      seat
    end
  end

  def occupied_seats
    @occupied_seats = [0] unless @occupied_seats
    @occupied_seats.sum
  end

  def validate!
    raise "Количество мест не может быть nil" if total_seats.nil?
    raise "Количество мест не может быть равно 0" if total_seats == 0
    raise "Невалидный формат ввода, количество мест может быть только в цифрах" unless total_seats.is_a? Integer
  end

  def valid?
    validate!
    true
  rescue
    false
  end

end
