require_relative 'instance_counter.rb'

class Station
  include InstanceCounter
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
    register_instance
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