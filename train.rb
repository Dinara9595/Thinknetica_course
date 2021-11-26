class Train

  #хочу чтобы пользователь мог только видеть скорость, но не устанавливать
  attr_reader :speed, :type, :number, :route, :station_start, :current_st, :wagons

  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0
    @wagons = []
  end

  def forward
    binding.irb
    if next_st
      @current_st = next_st
    else
      @current_st
    end
  end

  def backward
    if previous_st
      @current_st = previous_st
    else
      @current_st
    end
  end

  def next_st
    index = @route.station_list.index(@current_st) + 1
    @route.station_list[index] if index <= @route.station_list.size - 1
  end

  def previous_st
    index = @route.station_list.index(@current_st) - 1
    @route.station_list[index] if index >= 0
  end

  def add_wagon(wagon)
    @wagons << wagon if self.type == wagon.type
  end

  def delete_wagon(wagon)
    @wagons.delete(wagon)
  end

  def add_route(route)
    @route = route
    @current_st = @route.station_list.first
  end

  private

  attr_writer :speed  #хочу чтобы пользователь не мог устаналивать скорость

  def go(speed)
    self.speed = speed   # не хочу чтобы пользователь мог утсанавливать поезду скорость и всячески управлять
  end

  INITIAL_SPEED = 0

  def stop
    @speed = INITIAL_SPEED # не хочу чтобы пользователь мог останавливать поезда
  end

  #объявлять методы protected я не вижу необходимости в текущем классе
end