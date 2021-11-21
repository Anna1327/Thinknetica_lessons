# frozen_string_literal: true

require_relative 'module_instance_counter'
require_relative 'validation'

class Route
  include InstanceCounter
  include Validation
  attr_reader :stations

  validate :type, :stations, String

  def initialize(start_station, finish_station)
    register_instance
    @stations = [start_station, finish_station]
    validate!
  end

  def add_station(station)
    validate! station
    @stations.insert(-2, station)
  end

  def remove_station(station)
    validate! station
    @stations.delete(station)
  end

  def get_station_by_index(index)
    @stations[index]
  end
end
