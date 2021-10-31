require_relative 'module_instance_counter'
require_relative 'module_company'

class Train
  include CompanyCreator
  include InstanceCounter
  attr_accessor :speed, :number
  attr_reader :railway_carriages, :type, :route

  @@trains = []

  NUMBER_FORMAT = /^[\w\d]{3}-?[\w\d]{2}$/

  def self.find(number)
    @@trains.select { |train| train.number == number }
  end

  def self.all
    @@trains
  end

  def initialize(number, type)
    register_instance
    @@trains << self
    @number = number
    @type = type
    @railway_carriages = []
    @speed = 0
    @route = nil
    @carriages = []
    validation!
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

  def valid?
    validation!
    true
  rescue
    false
  end

  def block_carriages
    @carriages.each { |carriage| yield(carriage) }
  end

  protected

  def validation!
    raise "Неверная длина номера! Номер должен содержать от 5 до 6 символов" if self.number.length > 6 || self.number.length < 5
    raise "Неверный формат номера! Номер должен соответствовать формату XXX-XX или XXXXX" if number !~ NUMBER_FORMAT
    raise "Неверный тип поезда! Тип должен соответствовать значению passenger или cargo" if self.type != 'passenger' && self.type != 'cargo'
  end

  def add_carriage!(carriage)
    raise "Тип вагона должен быть #{self.type}." if carriage.type != self.type
    @carriages << carriage
  end
end