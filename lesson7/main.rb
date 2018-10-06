require_relative 'train'
require_relative 'route'
require_relative 'station'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'carriage'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'
require_relative 'manufacturer'
require_relative 'instance_counter'

@stations = []
@trains = []
@routes = []

def main_trains_list
  @trains.each_with_index do |train, index|
    puts "#{index + 1}. Поезд номер #{train.num}"
  end
end

def main_stations_list
  @stations.each_with_index do |station, index|
    puts "#{index + 1}. #{station.name}"
  end
end

def main_trains_on_route_list
  @trains_on_route = @trains.select(&:on_route?)
  @trains_on_route.each_with_index do |train, index|
    puts "#{index + 1}. Поезд номер #{train.num}"
  end
end

def main_routes_list
  @routes.each_with_index do |route, index|
    puts "#{index + 1}. Маршрут #{route.first.name} - #{route.last.name}"
  end
end

def trains_with_carriages
  @trains_with_carriages = []
  @trains.each do |train|
    @trains_with_carriages << train if train.carriages.any?
  end

  @trains_with_carriages.each_with_index do |train, index|
    puts "#{index + 1}. Поезд номер #{train.num}"
  end
end

def trains_with_carriages_any?
  @trains.select { |train| train.carriages.any? }.any?
end

def trains_on_route_any?
  @trains.select(&:on_route?).any?
end

def stations_with_trains
  @stations_with_trains = []
  @stations.each do |station|
    @stations_with_trains << station if station.trains.any?
  end

  @stations_with_trains.each_with_index do |station, index|
    puts "#{index + 1}. #{station.name}"
  end
end

def add_route_list
  puts 'Выберитe начальную и конечную станции маршрута'
  main_stations_list
  first = gets.to_i
  last = gets.to_i

  first_station = @stations[first - 1]
  last_station = @stations[last - 1]
end

def choose_train
  puts 'Выберитe поезд'
  main_trains_list
  train_index = gets.to_i
  train = @trains[train_index - 1]

  raise 'Внимательней выберите поезд' if train.nil?
end

# 1. Create station
def main_add_station
  begin
    puts 'Введите название станции'
    station_name = gets.chomp

    station = Station.new(station_name)
  rescue RuntimeError => e
    puts e.inspect
    retry
  end

  @stations << station
  puts "Создана станция #{station.name}"
end

# 2. Create train
def main_add_train
  begin
    puts 'Введите номер поезда (XXX(-)XX) и тип поезда (cargo или passenger)'
    @num = gets.chomp
    @type = gets.chomp.to_sym

    train = Train.new(@num, @type)
  rescue RuntimeError => e
    puts e
    retry
  end

  @trains << train
  puts "Создан поезд #{train.num} типа #{train.type}"
end

# 3. Create route
def main_add_route
  return puts 'Должно быть как минимум 2 станции' unless @stations.size > 1

  begin
    add_route_list

    raise 'Станции не найдены' unless first_station && last_station

    route = Route.new(@stations[first - 1], @stations[last - 1])
  rescue RuntimeError => e
    puts e
    retry
  end

  @routes << route
  puts "Создан маршрут #{route.first.name} - #{route.last.name}"
end

# 4. Assign a route to the train
def main_set_route
  return puts 'Нет маршрутов на железной дороге' unless @routes.any?
  return puts 'Нет поездов на железной дороге' unless @trains.any?

  choose_train

  puts 'Выберитe маршрут'
  main_routes_list
  route_index = gets.to_i
  route = @routes[route_index - 1]
  raise 'Внимательней выберите маршрут' if route.nil?

  train.set_route(route)
  print "Поезд номер #{train.num} поедет по "
  puts "маршруту #{route.first.name} - #{route.last.name}"
rescue RuntimeError => e
  puts e
  retry
end

# 5. Add station to route
def main_route_add_station
  return puts 'Нет маршрутов на железной дороге' unless @routes.any?
  return puts 'Нет станций на железной дороге' unless @stations.any?

  puts 'Выберитe маршрут'
  main_routes_list
  route_index = gets.to_i
  route = @routes[route_index - 1]
  raise 'Внимательней выберите маршрут' if route.nil?

  puts 'Какую станцию добавить'
  main_stations_list
  station_index = gets.to_i
  station = @stations[station_index - 1]
  raise 'Внимательней выберите станцию' if station.nil?
  raise 'Cтанция уже добавлена в маршрут' if route.stations.include?(station)

  route.add_station(station)
  print "Станция #{station.name} добавлена в "
  puts "маршрут #{route.first.name} - #{route.last.name}"
rescue RuntimeError => e
  puts e
  retry
end

# 6. Remove station from route
def main_route_delete_station
  return puts 'Нет маршрутов на железной дороге' unless @routes.any?

  puts 'Выберитe маршрут'
  main_routes_list
  route_index = gets.to_i
  route = @routes[route_index - 1]
  raise 'Внимательней выберите маршрут' if route.nil?

  puts 'Какую станцию удалить'
  @routes[route_index - 1].list_stations
  station_index = gets.to_i
  station = @stations[station_index - 1]
  raise 'Внимательней выберите станцию' if station.nil?

  route.delete_station(station)
  print "Станция #{station.name} удалена из "
  puts "маршрута #{route.first.name} - #{route.last.name}"
rescue RuntimeError => e
  puts e
  retry
end

# 7. Add carriage to train
def main_add_carriage
  return puts 'Нет поездов на железной дороге' unless @trains.any?

  choose_train

  if train.type == :passenger
    puts 'Количество посадочных мест в вагоне?'
  else
    puts 'Объем вагона?'
  end
  value = gets.to_i

  train.add_carriage(value, train.type)
  puts "В поезд номер #{train.num} добавлен вагон типа #{train.type}"
rescue RuntimeError => e
  puts e
  retry
end

# 8. Unhook the carriage from the train
def main_remove_carriage
  unless trains_with_carriages_any?
    return puts 'Нет поездов с вагонами на железной дороге'
  end

  puts 'Выберите поезд'
  trains_with_carriages

  train_index = gets.to_i
  train = @trains_with_carriages[train_index - 1]
  raise 'Внимательней выберите поезд' if train.nil?

  train.remove_carriage
  puts "Из поезда номер #{train.num} удален вагон типа #{train.type}"
rescue RuntimeError => e
  puts e
end

# 9. Move the train forward
def main_train_move_forward
  return puts 'Нет поездов на маршруте' unless trains_on_route_any?

  puts 'Выберите поезд'
  main_trains_on_route_list
  train_index = gets.to_i
  train = @trains_on_route[train_index - 1]

  raise 'Внимательней выберите поезд' if train.nil?

  train.move_forward
  puts "Поезд номер #{train.num} проехал вперед на 1 станцию"
rescue RuntimeError => e
  puts e
end

# 10. Move the train back
def main_train_move_backward
  return puts 'Нет поездов на маршруте' unless trains_on_route_any?

  puts 'Выберите поезд'
  main_trains_on_route_list
  train_index = gets.to_i
  train = @trains_on_route[train_index - 1]

  raise 'Внимательней выберите поезд' if train.nil?

  train.move_backward
  puts "Поезд номер #{train.num} проехал назад на 1 станцию"
rescue RuntimeError => e
  puts e
end

# 12. Train list at the station
def main_trains_on_station_list
  unless @stations.select { |station| station.trains.any? }.any?
    return puts 'Нет станций с поездами'
  end

  stations_with_trains

  station_index = gets.to_i
  station = @stations_with_trains[station_index - 1]

  raise 'Внимательней выберите станцию' if station.nil?

  station.all_trains_method do |train|
    print "Поезд номер #{train.num}, тип #{train.type}, "
    puts "кол-во вагонов #{train.carriages.size}"
  end
rescue RuntimeError => e
  puts e
  retry
end

# 13.  Display a list of cars at the train
def main_train_carriages_list
  unless trains_with_carriages_any?
    return puts 'Нет поездов с вагонами на железной дороге'
  end

  puts 'Выберите поезд'
  trains_with_carriages

  train_index = gets.to_i
  train = @trains_with_carriages[train_index - 1]
  raise 'Внимательней выберите поезд' if train.nil?

  @index = 0
  if train.type == :passenger
    train.all_carriages_method do |carriage|
      print "Вагон #{@index += 1}. Тип вагона #{carriage.type}, свободных мест "
      puts "#{carriage.empty_seats} занятых мест #{carriage.occupied_seats}"
    end
  else
    train.all_carriages_method do |carriage|
      print "Вагон #{@index += 1}. Тип вагона #{carriage.type}, свободного объема "
      puts "#{carriage.unused_volume} занятого объема #{carriage.occupied_volume}"
    end
  end
rescue RuntimeError => e
  puts e
  retry
end

# 14.  Take a seat or volume in a car
def main_occupy
  return puts 'Нет вагонов на железной дороге' unless trains_with_carriages_any?

  puts 'Выберите поезд'
  trains_with_carriages

  train_index = gets.to_i
  train = @trains_with_carriages[train_index - 1]

  raise 'Внимательней выберите поезд' if train.nil?

  puts 'Выберите вагон'
  @index = 0
  train.all_carriages_method do |carriage|
    puts "Вагон номер #{@index += 1}, Тип вагона #{carriage.type}"
  end

  carriage_index = gets.to_i
  carriage = train.carriages[carriage_index - 1]

  raise 'Внимательней выберите вагон' if carriage.nil?

  if carriage.type == :cargo
    print "Kол-во свободного объема #{carriage.unused_volume} занятого объема "
    puts "#{carriage.occupied_volume}. Сколько добавить объем?"
    value = gets.to_i

    raise 'Столько не поместится' if value > carriage.unused_volume

    carriage.occupy_volume(value)
    print "В вагон добавлено #{value} eдиниц объема. Kол-во свободного объема "
    puts "#{carriage.unused_volume} занятого объема #{carriage.occupied_volume}."
  else
    raise 'Вагон битком' if carriage.empty_seats.zero?

    carriage.occupy_seat
    puts "В вагоне занято одно место. Оставшихся мест #{carriage.empty_seats}"
  end
rescue RuntimeError => e
  puts e
  retry
end

loop do
  puts 'Выберитe номер команды
    1. Создать станцию
    2. Создать поезд
    3. Создать маршрут
    4. Назначить маршрут поезду
    5. Добавить станцию в маршрут
    6. Удалить станцию из маршрута
    7. Добавить вагон к поезду
    8. Отцепить вагон от поезда
    9. Перемещать поезд по маршруту вперед
    10. Перемещать поезд по маршруту назад
    11. Просмотреть список станций
    12. Cписок поездов на станции
    13. Выводить список вагонов у поезда
    14. Занимать место или объем в вагоне
    0. Закончить'

  choice = gets.to_i

  case choice

  when 1  # 1. Create station
    main_add_station
  when 2  # 2. Create train
    main_add_train
  when 3  # 3. Create route
    main_add_route
  when 4  # 4. Assign a route to the train
    main_set_route
  when 5  # 5. Add station to route
    main_route_add_station
  when 6  # 6. Remove station from route
    main_route_delete_station
  when 7  # 7. Add carriage to train
    main_add_carriage
  when 8  # 8. Unhook the carriage from the train
    main_remove_carriage
  when 9  # 9. Move the train forward
    main_train_move_forward
  when 10 # 10. Move the train back
    main_train_move_backward
  when 11  # 11. View station list
    return puts 'Нет станций на железной дороге' unless @stations.any?

    puts 'Список станций'
    main_stations_list
  when 12  # 12. Train list at the station
    main_trains_on_station_list
  when 13  # 13. Display a list of cars at the train
    main_train_carriages_list
  when 14  # 14. Take a seat or volume in a car
    main_occupy
  when 0
    exit
  end
end
