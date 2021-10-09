require_relative 'module_instance_counter'

class Route
  include InstanceCounter
  attr_reader :stations

  def initialize(start_station, finish_station)
    register_instance
    @stations = [start_station, finish_station]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    @stations.delete(station)
  end

  def get_station_by_index(index)
    @stations[index]
  end
end