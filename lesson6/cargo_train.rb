require_relative 'train'

class CargoTrain < Train

  def initialize(number, type = "cargo")
    valid?
    super
  end
end