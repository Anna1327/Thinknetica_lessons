require_relative 'railway_carriage'

class PassengerCarriage < RailwayCarriage
    
  def initialize(type = "passenger")
    super
  end
end