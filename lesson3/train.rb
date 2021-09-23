class Train
  attr_accessor :speed
  attr_reader :railway_carriages, :current_station

  def initialize(number, type, railway_carriages)
    @number = number
    @type = type
    @railway_carriages = railway_carriages
    @speed = 0
    @route = nil
    @current_station = nil
  end

  def stop
    @speed = 0
  end

  def add_railway_carriage
    if @speed == 0
      @railway_carriages += 1
    else
      puts "Скорость поезда выше 0"
    end
  end

  def remove_railway_carriage
    if @speed == 0
      @railway_carriages -= 1
    else
      puts "Скорость поезда выше 0"
    end
  end

  def assign_route(route)
    #поместить поезд на первую станцию в маршруте
    @stations = route.stations
    @count = 0
    @current_station = @stations[@count]
  end

  def go_ahead
    # + 1 станция вперед по маршруту
    @count += 1
    @current_station = @stations[@count]
  end

  def go_back
    # - 1 станция назад по маршруту
    @count -= 1
    @current_station = @stations[@count]
  end

  def next_station
    @stations[@count+1]
  end

  def previous_station
    @stations[@count-1]
  end
end