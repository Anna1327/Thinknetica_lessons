# frozen_string_literal: true

require_relative 'railway_carriage'

class CargoCarriage < RailwayCarriage
  def initialize(type = 'cargo')
    super
  end
end
