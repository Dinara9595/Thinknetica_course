require_relative 'manufacturing_company.rb'
require_relative 'accessors.rb'
require_relative 'validation.rb'

class Wagons
  include ManufacturingCompany
  include Validation
  extend Accessors

  strong_attr_accessor :type, Wagons
  attr_accessor_with_history :wagon
  history :wagon

  validate :type, :presence
  validate :type, :type, String

  attr_reader :type
  def initialize(type)
    @type = type
    validate!
  end
end