class RailwayCarriage
  include CompanyCreator
  attr_reader :type, :total_place, :used_place
    
  def initialize(type,total_place)
    @total_place = total_place
    @used_place = 0
    @type = type
  end

  def free_place
    @total_place - @used_place
  end
end