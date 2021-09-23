require_relative 'station'
require_relative 'route'
require_relative 'train'

station_murmansk = Station.new("Murmanks")
station_moscow = Station.new("Moscow")
station_saint_p = Station.new("Saint-Petersburg")
station_vologda = Station.new("Vologda")
station_bologoe = Station.new("Bologoe")

train = Train.new('236', 'pass', 8)
train_2 = Train.new('137', 'pass', 6)

route_1 = Route.new(station_murmansk, station_moscow)
route_2 = Route.new(station_saint_p, station_moscow)

train.assign_route(route_1)
train_2.assign_route(route_2)

puts train.current_station
puts train_2.current_station

route_1.add_station(station_saint_p)

puts train.next_station
puts train.previous_station

train.go_ahead
puts train.current_station

train.speed = 80
train.remove_railway_carriage
puts train.railway_carriages
train.stop
train.add_railway_carriage
puts train.railway_carriages

station_murmansk.receive_train(train)
puts station_murmansk.trains

puts station_murmansk.get_trains_by_type('pass')

puts route_1.get_station_by_index(1)


