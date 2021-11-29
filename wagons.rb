require_relative 'manufacturing_company.rb'

class Wagons
  include ManufacturingCompany
  attr_reader :type
  def initialize(type)
    @type = type
  end
end