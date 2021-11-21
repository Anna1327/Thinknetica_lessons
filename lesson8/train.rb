# frozen_string_literal: true

require_relative 'module_instance_counter'
require_relative 'module_company'
require_relative 'validation'

class Train
  include CompanyCreator
  include InstanceCounter
  include Validation
  attr_accessor :speed, :number
  attr_reader :railway_carriages, :type, :route

  NUMBER_FORMAT = /^[\w\d]{3}-?[\w\d]{2}$/.freeze

  validate :format, :number, NUMBER_FORMAT

  def self.find(number)
    @trains.select { |train| train.number == number }
  end

  def self.all
    @trains
  end

  def initialize(number, type)
    @trains = []
    register_instance
    @trains << self
    @number = number
    @type = type
    @railway_carriages = []
    @speed = 0
    @route = nil
    @carriages = []
    validate!
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
    @route.get_station_by_index(@current_station_index + 1) if @current_station_index < @route.stations.size - 1
  end

  def previous_station
    @route.get_station_by_index(@current_station_index - 1) unless @current_station_index.zero?
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
  rescue StandardError
    false
  end

  def block_carriages(&block)
    @carriages.each(&block)
  end

  protected

  def validation!
    raise 'Номер должен содержать от 5 до 6 символов' if number.length > 6 || number.length < 5
    raise 'Тип должен соответствовать значению passenger или cargo' if type != 'passenger' && type != 'cargo'
  end

  def add_carriage!(carriage)
    raise "Тип вагона должен быть #{type}." if carriage.type != type

    @carriages << carriage
  end
end
