class Train
  attr_accessor :speed
  attr_reader :railway_carriages

  def initialize(number, type, railway_carriages)
    @number = number
    @type = type
    @railway_carriages = railway_carriages
    @speed = 0
    @route = nil
    @current_station_index = nil
  end

  def stop
    @speed = 0
  end

  def add_railway_carriage
    @railway_carriages += 1 if @speed.zero?
  end

  def remove_railway_carriage
    @railway_carriages -= 1 if @speed.zero?
  end

  def assign_route(route)
    @route = route
    @current_station_index = 0
    current_station = @route.get_station_by_index(@current_station_index)
    current_station.receive_train(self)
  end

  def go_ahead
    @current_station_index += 1
    next_station
  end

  def go_back
    @current_station_index -= 1
    previous_station
  end

  def next_station
    @route.get_station_by_index(@current_station_index + 1)
  end

  def previous_station
    @route.get_station_by_index(@current_station_index - 1)
  end

  def current_station
    @route.get_station_by_index(@current_station_index)
  end
end