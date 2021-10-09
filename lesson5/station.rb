require_relative 'module_instance_counter'

class Station
  include InstanceCounter

  attr_reader :trains, :name

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    register_instance
    @@stations << self
    @name = name
    @trains = []
  end
  
  def receive_train(train)
    @trains << train
  end

  def depart_train(train)
    @trains.delete(train)
  end

  def get_trains_by_type(type)
    @trains.select { |train| train.type == type }            
  end

  def pass_trains
    get_trains_by_type('passenger')          
  end

  def cargo_trains
    get_trains_by_type('cargo')          
  end
end