require_relative 'validation.rb'

class PassengerWagons < Wagons
  include Validation

  attr_reader :total_seats, :occupied_seats, :available_seats
  validate :total_seats, :presence
  validate :total_seats, :type, Integer

  def initialize(total_seats)
    @total_seats = total_seats
    @available_seats = total_seats
    occupied_seats
    super("пассажирский")
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
end
