class Route
  attr_reader :stations

  def initialize(start_station, finish_station)
    @start_station = start_station
    @finish_station = finish_station
    @stations = [start_station, finish_station]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    @stations.delete(station)
  end

  def get_station_by_index(index)
    return @stations[index]
  end
end