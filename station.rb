require_relative 'instance_counter.rb'

class Station
  include InstanceCounter
  attr_reader :name, :train_now

  NAME_FORMAT = /^[а-яa-z\d]{3,30}$/i

  class << self
    def all
      @all ||= []
    end
  end


  def initialize(name)
    @name = name
    @train_now = []
    self.class.all << self
    register_instance
    validate!
  end

  def validate!
    raise "Название станции не может быть nil" if name.nil?
    raise "Название станции должно быть не менее трех символов" if name.length < 3
    raise "Название станции должно быть не более тридцати символов" if name.length > 30
    raise "Невалидный формат имени" if name !~ NAME_FORMAT
  end

  def valid?
    validate!
    true
  rescue
    false
  end

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