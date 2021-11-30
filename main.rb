require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'wagons.rb'
require_relative 'passenger_wagons.rb'
require_relative 'cargo_wagons.rb'


#rr = RailRoad.new
class RailRoad

  TRAIN_GO = [
      "Введите 1, если вы хотите, чтобы поезд переместился вперед на одну станцию",
      "Введите 2, если вы хотите, чтобы поезд переместился назад на одну станцию"
  ]

  START_MENU = [
      "Введите 1, если вы хотите создать станцию, поезд или маршрут",
      "Введите 2, если вы хотите произвести операции с созданными объектами",
      "Введите 3, если вы хотите вывести текущие данные об объектах",
      "Введите 0, если вы хотите закончить программу"
  ]

  ONE_LEVEL = [
      "Введите 1, если вы хотите создать станцию",
      "Введите 2, если вы хотите создать поезд",
      "Введите 3, если вы хотите создать маршрут"
  ]

  TWO_LEVEL = [
      "Введите 1, если вы хотите добавить промежуточную станцию в маршрут",
      "Введите 2, если вы хотите удалить станцию из маршрута",
      "Введите 3, если вы хотите назначить маршрут поезду",
      "Введите 4, если вы хотите добавить вагоны поезду",
      "Введите 5, если вы хотите отцепить вагоны от поезда",
      "Введите 6, если вы хотите перемещать поезд по маршруту",
      "Введите 7, если хотите занять место или объем в вагоне"
  ]

  THREE_LEVEL = [
      "Введите 1, если вы хотите посмотреть список поездов на станции",
      "Введите 2, если вы хотите посмотреть список созданных станций",
      "Введите 3, если вы хотите посмотреть список вагонов у поезда"
  ]
  attr_reader :stations, :routes, :trains, :wagons

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end

  def menu
    start_menu
    input0 = input
    case input0
    when 1
      one_level
      input1 = gets.to_i
      case input1
      when 1
        create_station
      when 2
        create_train
      when 3
        create_route
      else
        error
      end
    when 2
      two_level
      input2 = gets.to_i
      case input2
      when 1
        add_station_to_route
      when 2
        delete_station_from_route
      when 3
        add_route_to_train
      when 4
        add_wagons_to_train
      when 5
        delete_wagons_to_train
      when 6
        train_go_to_by_route
      when 7
        occupied_volume_or_seats
      else
        error
      end
    when 3
      three_level
      input3 = gets.to_i
      case input3
      when 1
        see_trains_on_station
      when 2
        error_availability(@stations, "станцию")
        @stations.each {|station| puts station}
      when 3
        see_wagons_of_train
      else
        error
      end
    when 0
      end_level
    else
      error
    end
  end

  private

  def invalid_input
    raise
  end

  def error
    begin
      invalid_input
    rescue
      puts "Необходимо выбрать значение из предложенных"
    end
  end

  def error_availability(arr_el_rr, element_rr)
    arr_el_rr.any? || puts("Сначала создайте #{element_rr}")
  end

  def start_menu
    puts START_MENU
  end

  def one_level
    puts ONE_LEVEL
  end

  def two_level
    puts TWO_LEVEL
  end

  def three_level
    puts THREE_LEVEL
  end

  def end_level
    puts "Конец"
  end

  def create_station
    begin
    puts "Введите название станции"
    name = gets.chomp
    station = Station.new(name)
    rescue Exception => e
      puts "Error: #{e.message}"
    retry
    end
    @stations << station
    puts "Создана станция #{station}"
  end

  def create_train
    begin
      puts "Введите номер поезда"
      number = gets.chomp
      puts "Введите тип поезда"
      type = gets.chomp
      train = Train.new(number, type)
    rescue Exception => e
      puts "Error: #{e.message}"
      retry
    end
    @trains << train
    puts "Создан поезд #{train}"
  end

  def create_route
    return unless error_availability(@stations, "станции")
    first_station_index = selection_and_check(@stations, "первую станцию")
    remaining_stations = @stations.dup
    remaining_stations.delete_at(first_station_index)
    second_station_index = selection_and_check(remaining_stations, "последнюю станцию")
    @routes << Route.new(@stations[first_station_index], remaining_stations[second_station_index])
    @routes.last
  end

  def display(arr_el_rr, element_rr)
    arr_el_rr.each_with_index do |element, index|
      puts "Введите #{index}, чтобы выбрать #{element_rr} #{element}"
    end
  end

  def selection(arr_el_rr, element_rr)
    puts "Выберите #{element_rr}"
    display(arr_el_rr, element_rr)
  end

  def input
    begin
      @input_p = gets.chomp
      Integer(@input_p)
    rescue
      puts "Неверный ввод! Необходимо ввести число!"
      input
    end
    @input_p.to_i
  end

  def selection_and_check(arr_el_rr, element_rr)
    selection(arr_el_rr, element_rr)
    choice = nil
    until choice
      choice = input
      choice = nil unless arr_el_rr[choice]
      error unless choice
    end
    choice
  end

  def add_station_to_route
    return unless error_availability(@stations, "станции") && error_availability(@routes, "маршрут")
    input_r = selection_and_check(@routes, "маршрут")
    input_s = selection_and_check(@stations, "станцию")

    if @routes[input_r].station_list.include?(@stations[input_s])
      puts "Такая станция уже есть в этом маршруте"
    else
      puts "Станция добавлена в маршрут"
      @routes[input_r].add_station(@stations[input_s])
    end
  end

  def delete_station_from_route
    return unless error_availability(@routes, "маршрут")
    input_r = selection_and_check(@routes, "маршрут")
    input_rs = selection_and_check(@routes[input_r].station_list, "станцию")

    if @routes[input_r].station_list.include?(@stations[input_rs])
      @routes[input_r].delete_station(@stations[input_rs])
    else
      error
    end
  end

  def add_route_to_train
    return unless error_availability(@routes, "маршрут") &&
        error_availability(@trains, "поезд")

    input_t = selection_and_check(@trains, "поезд")
    route_tr = @trains[input_t].route

    unless route_tr
      input_r = selection_and_check(@routes, "маршрут")
      @trains[input_t].add_route(@routes[input_r])
      puts "Маршрут успешно добавлен"
      return
    end

    if route_tr
      puts ["У этого поезда уже есть маршрут #{route_tr}",
            "Введите 1, если хотите оставить прежний маршрут",
            "Введите 2, если хотите заменить маршрут"]
      input_ch = input
      case input_ch
      when 1
        @trains[input_t]
      when 2
        input_r = selection_and_check(@routes, "маршрут")

        @trains[input_t].add_route(@routes[input_r])
        puts "Маршрут успешно изменен"
      else
        error
      end
    end
  end

  def add_wagons_to_train
    return unless error_availability(@trains, "поезд")
    input_t = selection_and_check(@trains, "поезд")
    begin
    if @trains[input_t].type == "пассажирский"
      puts "Введите количество мест в вагоне"
      input_seats = gets.chomp
      check_seats = Integer(input_seats)
      @trains[input_t].add_wagon(PassengerWagons.new(check_seats))
    else @trains[input_t].type == "грузовой"
      puts "Введите объем вагона"
      input_volume = gets.chomp
      check_volume = Integer(input_volume)
      @trains[input_t].add_wagon(CargoWagons.new(check_volume))
    end
    rescue Exception => e
      puts "Error: #{e.message}"
      retry
    end
    puts "К поезду добавлен один вагон по типу"
  end

  def delete_wagons_to_train
    return unless error_availability(@trains, "поезд")
    input_t = selection_and_check(@trains, "поезд")
    wagons_train = @trains[input_t].wagons
    if wagons_train.empty?
      return puts "Сначала добавьте вагон поезду"
    end

    if wagons_train
      input_w = selection_and_check(@trains[input_t].wagons, "вагон")
      @trains[input_t].delete_wagon([input_w])
      puts "Вагон успешно отцеплен от поезда"
    end
  end

  def train_go_to_by_route
    return unless error_availability(@trains, "поезд") &&
        error_availability(@routes, "маршрут")

    input_t = selection_and_check(@trains, "поезд")
    train_route = @trains[input_t].route
    if train_route
      puts TRAIN_GO
    else
      return puts "Сначала присвойте маршрут поезду"
    end
    input_go = input
    case input_go
    when 1
      puts "Текущая станция #{@trains[input_t].forward}"
    when 2
      puts "Текущая станция #{@trains[input_t].backward}"
    else
      error
    end
  end

  def see_trains_on_station
    return unless error_availability(@stations, "станцию") && error_availability(@trains, "поезд")
    input_s = selection_and_check(@stations, "станцию")
    train_of_station = @stations[input_s].train_now
    if train_of_station.empty?
      puts "На данной станции нет поездов"
    else
      @stations[input_s].train_on_station do |train|
        puts ["Номер поезда: #{train.number}",
              "Тип поезда: #{train.type}",
              "Количество вагонов: #{train.wagons.size}"]
      end
    end
  end

  def see_wagons_of_train
    return unless error_availability(@trains, "поезд")
    input_t = selection_and_check(@trains, "поезд")
    return unless error_availability(@trains[input_t].wagons, "вагон/добавьте его выбранному поезду")
    @trains[input_t].wagons
    train_type = @trains[input_t].type
    if train_type == "пассажирский"
      i=0
      @trains[input_t].wagon_train do |wagon|
      puts ["номер вагона: #{i}",
            "тип вагона: #{wagon.type}",
            "количество свободных мест: #{wagon.available_seats}",
            "количество занятых мест: #{wagon.occupied_seats}"]
      i+=1
      end
    else train_type == "грузовой"
    i=0
    @trains[input_t].wagon_train do |wagon|
      puts ["номер вагона: #{i}",
            "тип вагона: #{wagon.type}",
            "количество свободного объема: #{wagon.available_volume}",
            "количество занятого объема: #{wagon.occupied_volume}"]
      i+=1
    end
    end
  end

  def occupied_volume_or_seats
    return unless error_availability(@trains, "поезд")
    input_t = selection_and_check(@trains, "поезд")
    wagons = @trains[input_t].wagons
    return unless error_availability(wagons, "вагон/добавьте его выбранному поезду")
    input_w = selection_and_check(wagons, "вагон")
    type_train = @trains[input_t].type
    if type_train == "пассажирский"
      wagons[input_w].take_a_seat(1)
    else type_train == "грузовой"
    puts "Введите количество объема, который хотите занять"
    begin
      input_v = gets.chomp
      check_volume = Integer(input_v)
      wagons[input_w].take_a_volume(check_volume)
    rescue Exception => e
      puts "Error: #{e.message}"
      retry
    end
    end
  end
end