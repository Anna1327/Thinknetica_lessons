require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'railway_carriage'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'

class RailRoad

  attr_reader :stations, :trains, :routes, :carriages, :name

  MENU_COMMANDS = [
    { command: '1', title: 'создать станцию, поезд, вагон или маршрут', action: :choose_creation },
    { command: '2', title: 'произвести операции с объектами', action: :operations_with_objects },
    { command: '3', title: 'вывести текущие данные об объектах', action: :current_data },
    { command: '0', title: 'завершить программу', action: :exit_programm }
  ]
  
  CREATE_ACTIONS = [
    { command: '1', title: 'создать станцию', action: :create_station },
    { command: '2', title: 'создать поезд', action: :create_train },
    { command: '3', title: 'создать вагон', action: :create_carriage },
    { command: '4', title: 'создать маршрут', action: :create_route },
    { command: '0', title: 'вернуться к меню', action: :menu }
  ]

  STATION_ACTIONS = [
    { command: '1', title: 'создать станцию', action: :create_station },
    { command: '2', title: 'принять поезд', action: :add_train_to_station },
    { command: '3', title: 'отправить поезд', action: :delete_train_from_station },
    { command: '4', title: 'посмотреть список всех станций', action: :show_all_stations },
    { command: '5', title: 'посмотреть список грузовых поездов', action: :get_list_cargo_train },
    { command: '6', title: 'посмотреть список пассажирских поездов', action: :get_list_pass_train },
    { command: '0', title: 'вернуться к меню', action: :menu }
  ]

  TRAIN_ACTIONS = [
    { command: '1', title: 'создать поезд', action: :create_train },
    { command: '2', title: 'назначить маршрут', action: :add_route_to_train },
    { command: '3', title: 'добавить вагон', action: :add_carriage_to_train },
    { command: '4', title: 'удалить вагон', action: :del_carriage_from_train },
    { command: '5', title: 'ехать вперед', action: :go_ahead },
    { command: '6', title: 'ехать назад', action: :go_back },
    { command: '0', title: 'вернуться к меню', action: :menu }
  ]

  ROUTE_ACTIONS = [
    { command: '1', title: 'создать маршрут', action: :create_route },
    { command: '2', title: 'добавить станцию в маршрут', action: :add_station_to_route },
    { command: '3', title: 'удалить станцию из маршрута', action: :del_station_from_route },
    { command: '0', title: 'вернуться к меню', action: :menu }
  ]

  CHOOSE_OBJECT = [
    { command: '1', title: 'произвести операции со станцией', object: STATION_ACTIONS },
    { command: '2', title: 'произвести операции с поездом', object: TRAIN_ACTIONS },
    { command: '3', title: 'произвести операции с маршрутом', object: ROUTE_ACTIONS },
    { command: '0', title: 'вернуться к меню' }
  ]

  def initialize
    @stations = []
    @trains = []
    @carriages = []
    @routes = []
  end

  def show_actions(actions, title = nil)
    text = "Введите число"
    text += title ? " для #{title}:\n" : ":\n"
    actions.each do |action|
      text += " - #{action[:command]} чтобы #{action[:title]}\n"
    end
    puts text
  end
  
  def exit_programm
    exit
  end

  def menu
    loop do
      self.show_actions(MENU_COMMANDS)
      action = gets.chomp.to_i
      send(MENU_COMMANDS[action - 1][:action])
    end	
  end

  def choose_creation
    loop do
      self.show_actions(CREATE_ACTIONS)
      action = gets.chomp.to_i
      break if action == 0
      send(CREATE_ACTIONS[action - 1][:action])
    end
  end

  private

  def create_station
    puts "Введите название станции"
    station_name = gets.chomp
    st = Station.new(station_name)
    @stations << st
  end

  def create_train
    while true
      puts "Введите тип поезда: 1 - грузовой; 2 - пассажирский: "
      train_type = gets.chomp.to_i
      break if [1, 2].include?(train_type)	
    end
    puts "Введите номер поезда:"
    train_number = gets.chomp.to_i
    train = train_type == 1 ? CargoTrain.new(train_number) : PassengerTrain.new(train_number)
    puts "Выберите тип поезда: 1 - грузовой; 2 - пассажирский"
    @trains << train
  end

  def create_carriage
    while true
      puts "Выберите тип вагона: 1 - грузовой; 2 - пассажирский"
      carriage_type = gets.chomp.to_i
      break if [1, 2].include?(carriage_type)	
    end
    carriage = carriage_type == 1 ? CargoCarriage.new : PassengerCarriage.new
    @carriages << carriage
  end

  def create_route
    while true
      puts "Введите через запятую начальную и конечную станции маршрута:"
      stations = gets.chomp.split(',')
      break if stations.size == 2
    end
    route = Route.new(stations[0], stations[1])
    @routes << route
  end

  def show_all_stations
    if @stations.size.zero?
      puts "Нет станций"
    else
      puts "Количество станций: #{@stations.size}"
      @stations.each { |station| puts station.name }
    end
  end

  def add_train_to_station
    puts "Введите название станции: "
    station_name = gets.chomp
    @station = find_station(station_name)
    puts "Введите номер поезда: "
    train_number = gets.chomp.to_i
    @train = find_train(train_number)
    @station.receive_train(@train)
  end

  def delete_train_from_station
    puts "Введите название станции: "
    station_name = gets.chomp
    @station = find_station(station_name)
    puts "Введите номер поезда: "
    train_number = gets.chomp.to_i
    @train = find_train(train_number)
    @station.depart_train(@train)
  end

  def get_list_cargo_train
    puts "Введите название станции: "
    station_name = gets.chomp
    station = find_station(station_name)
    if station.cargo_trains.size.zero?
      puts "Нет грузовых поездов"
    else
      puts "Список грузовых поездов: #{station.cargo_trains}"
    end
  end

  def get_list_pass_train
    puts "Введите название станции: "
    station_name = gets.chomp
    station = find_station(station_name)
    station.pass_trains
    if station.pass_trains.size.zero?
      puts "Нет пассажирских поездов"
    else
      puts "Список пассажирских поездов: #{station.cargo_trains}"
    end
  end

  def current_data
    puts "Количество станций: #{@stations.size}, список станций: 
    #{@stations.each { |station| puts "#{station.name}" }}\n"
    puts "Количество поездов: #{@trains.size}, список поездов: 
    #{@trains.each { |train| puts "номер поезда: #{train.number}, тип поезда #{train.type}" }}\n"
    puts "Количество маршрутов: #{@routes.size}, список маршрутов: 
    #{@routes.each { |route| puts "#{route.stations}" }}\n"
  end

  def operations_with_objects
    show_actions(CHOOSE_OBJECT)
    command = gets.chomp.to_i
    action = CHOOSE_OBJECT[command - 1][:object]
    show_actions(action)
    command = gets.chomp.to_i
    send(action[command - 1][:action])
  end

  def add_route_to_train
    puts "Введите номер поезда: "
    number = gets.chomp.to_i
    puts "Введите начальную станцию маршрута: "
    first_station = gets.chomp
    puts "Введите конечную станцию маршрута: "
    last_station = gets.chomp
    train = find_train(number)
    route = find_route(first_station, last_station)
    current_station = train.assign_route(route)
    station = self.stations.select { |st| st.name == current_station}.first
    station.receive_train(train)
  end

  def add_carriage_to_train
    while true
      print "Введите тип вагона: 1 - грузовой, 2 - пассажирский: "
      carriage_type = gets.chomp.to_i
      break if [1, 2].include?(carriage_type)	
    end
    carriage = carriage_type == 1 ? CargoCarriage.new : PassengerCarriage.new
    print "Введите номер поезда: "
    train_number = gets.chomp.to_i
    train = self.find_train(train_number)
    return if !train
    train.add_railway_carriage(carriage)
    puts "Добавлен #{carriage.type} вагон к поезду #{train.number}"
  end

  def del_carriage_from_train
    puts "Введите номер поезда: "
    train_number = gets.chomp.to_i
    train = self.find_train(train_number)
    return if !train
    train.remove_railway_carriage
    puts "Удален вагон из поезда #{train.number}"
  end

  def go_ahead
    puts "Введите номер поезда: "
    train_number = gets.chomp.to_i
    train = self.find_train(train_number)
    current_station = train.current_station
    current_station = find_current_station(current_station)
    current_station.depart_train(train)
    current_station = train.go_ahead
    current_station = find_current_station(current_station)
    current_station.receive_train(train)
  end

  def go_back
    puts "Введите номер поезда: "
    train_number = gets.chomp.to_i
    train = self.find_train(train_number)
    current_station = train.current_station
    current_station = find_current_station(current_station)
    current_station.depart_train(train)
    current_station = train.go_back
    current_station = find_current_station(current_station)
    puts "покажи поезд #{train}"
    current_station.receive_train(train)
  end

  def add_station_to_route
    puts "Введите начальную станцию маршрута: "
    first_station = gets.chomp
    puts "Введите конечную станцию маршрута: "
    last_station = gets.chomp
    puts "Введите название станции: "
    station_name = gets.chomp
    puts "покажи маршрут: #{find_route(first_station, last_station).inspect}"
    find_route(first_station, last_station).add_station(station_name)
  end

  def del_station_from_route
    puts "Введите начальную станцию маршрута: "
    first_station = gets.chomp
    puts "Введите конечную станцию маршрута: "
    last_station = gets.chomp
    puts "Введите название станции: "
    station_name = gets.chomp
    puts "покажи маршрут: #{find_route(first_station, last_station).inspect}"
    find_route(first_station, last_station).remove_station(station_name)
  end

  def find_current_station(current_station)
    @stations.select { |st| st.name == current_station}.first
  end

  def find_train(number)
    @trains.select { |train| train.number == number }.first
  end

  def find_station(name)
    @stations.select { |station| station.name == name }.first
  end

  def find_route(first_station, last_station)
    @routes.select { |route| route.stations == [first_station, last_station] }.first
  end

end

RailRoad.new.menu
