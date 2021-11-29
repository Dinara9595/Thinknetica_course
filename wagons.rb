require_relative 'manufacturing_company.rb'

ARRAY_TYPE = %w[пассажирский грузовой]

class Wagons
  include ManufacturingCompany
  attr_reader :type
  def initialize(type)
    @type = type
    validate!
  end

  def validate!
    raise "Тип вагона не может быть nil" if type.nil?
    raise "Неверный ввод! Тип вагона может быть либо грузовой, либо пассажирский" unless ARRAY_TYPE.include?(type)
  end

  def valid?
    validate!
    true
  rescue
    false
  end
end