# frozen_string_literal: true

require_relative 'railway_carriage'

class CargoCarriage < RailwayCarriage
  def initialize(total_place, type = 'cargo')
    @total_place = total_place
    @used_place = 0
    super
  end

  def take_volume(volume)
    validation!(volume)
    @used_place += volume
  end

  def validation!(volume)
    raise 'Для выполнения операции не хватает объема' if @used_place + volume > @total_place
  end
end
