# frozen_string_literal: true

require_relative 'railway_carriage'

class PassengerCarriage < RailwayCarriage
  def initialize(total_place, type = 'passenger')
    @total_place = total_place
    @used_place = 0
    super
  end

  def take_seat
    validation!
    @used_place += 1
  end

  def validation!
    raise 'Для выполнения операции не хватает мест' if @used_place + 1 > @total_place
  end
end
