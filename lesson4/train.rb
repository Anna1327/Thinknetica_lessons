class Train
  attr_accessor :speed, :number
  attr_reader :railway_carriages, :type, :route

  def initialize(number, type)
    @number = number
    @type = type
    @railway_carriages = []
    @speed = 0
    @route = nil
  end

  def stop
    @speed = 0
  end

  def add_railway_carriage(carriage, type = carriage.type)
    @railway_carriages << carriage if @speed.zero? && carriage.type == type
  end

  def remove_railway_carriage
    @railway_carriages.pop if @speed.zero?
  end

  def assign_route(route)
    @route = route
    @current_station_index = 0
    @route.get_station_by_index(@current_station_index)
  end

  def go_ahead
    return unless next_station
    @current_station_index += 1
    @route.get_station_by_index(@current_station_index)
  end

  def go_back
    return unless previous_station
    @current_station_index -= 1
    @route.get_station_by_index(@current_station_index)
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

  def check_carriage_type(carriage)
    carriage.type
  end
end