class Train
  attr_accessor :speed
  attr_reader :railway_carriages, :type

  def initialize(number, type, railway_carriages)
    @number = number
    @type = type
    @railway_carriages = railway_carriages
    @speed = 0
    @route = nil
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
    return unless next_station
    current_station = @route.get_station_by_index(@current_station_index)
    current_station.depart_train(self)
    @current_station_index += 1
    current_station.receive_train(self)
  end

  def go_back
    return unless previous_station
    current_station = @route.get_station_by_index(@current_station_index)
    current_station.depart_train(self)
    @current_station_index -= 1
    current_station.receive_train(self)
  end

  def next_station
    if @current_station_index < @route.stations.size - 1
      @route.get_station_by_index(@current_station_index + 1)
    end
  end

  def previous_station
    unless @current_station_index.zero?
      @route.get_station_by_index(@current_station_index - 1)
    end
  end

  def current_station
    @route.get_station_by_index(@current_station_index)
  end
end