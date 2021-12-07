require_relative 'instance_counter.rb'
require_relative 'accessors.rb'
require_relative 'validation.rb'

class Station
  include InstanceCounter
  include Validation
  extend Accessors

  NAME_FORMAT = /^[а-яa-z\d]{3,30}$/i

  strong_attr_accessor :name, Station
  validate :name, :presence
  validate :name, :format, NAME_FORMAT
  attr_reader :name, :train_now

  class << self
    def all
      @all ||= []
    end
  end


  def initialize(name)
    @name = name
    @train_now = []
    self.class.all << self
    validate!
    register_instance
  end

  def train_on_station(&block)
    @train_now.each {|train| block.call(train)}
  end
  #s.train_on_station {|train| puts train}

  def add_train(train)
    @train_now << train
  end

  def trains_by(type)
    @train_now.select { |train| train.type == type }
  end

  def send_of_train(train)
    @train_now.delete(train)
  end
end