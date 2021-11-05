# frozen_string_literal: true

class RailwayCarriage
  include CompanyCreator
  attr_reader :type

  def initialize(type)
    @type = type
  end
end
