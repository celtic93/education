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
  @trains.each_with_index {|train, index| puts "#{index+1}. Поезд номер #{train.num}"}
end

def main_stations_list
  @stations.each_with_index {|station, index| puts "#{index+1}. #{station.name}"}
end

def main_trains_on_route_list
  @trains_on_route = @trains.select {|train| train.on_route?}
  @trains_on_route.each_with_index {|train, index| puts "#{index+1}. Поезд номер #{train.num}"} 
end

def main_routes_list
  @routes.each_with_index {|route, index| puts "#{index+1}. Маршрут #{route.first.name} - #{route.last.name}"}
end

def trains_with_carriages
  @trains.each_with_index do |train, index|
    puts "#{index+1} #{train.num}" if train.carriages.any?
  end
end

def stations_with_trains
  @stations.each_with_index do |station, index|
    puts "#{index+1} #{station.name}" if station.trains.any?
  end
end

def main_add_station  #1. Создать станцию

  begin
    puts 'Введите название станции'
    station_name = gets.chomp

    station = Station.new(station_name)
  rescue Exception => e
    puts e
    retry
  end
    
  @stations << station
  puts "Создана станция #{station.name}"
end

def main_add_train  #2. Создать поезд
    
  begin
    puts 'Введите номер поезда и тип поезда'
    @num = gets.chomp
    @type = gets.chomp.to_sym

    train = Train.new(@num, @type)
  rescue Exception => e
    puts e
    retry
  end

  @trains << train
  puts "Создан поезд #{train.num} типа #{train.type}"
end

def main_add_route  #3. Создать маршрут  

  begin
    puts 'Выберитe начальную и конечную станции маршрута'
    main_stations_list
    first = gets.to_i
    last = gets.to_i

    first_station = @stations[first-1]
    last_station = @stations[last-1]

    raise "Станции не найдены" unless first_station && last_station 
    route = Route.new(@stations[first-1], @stations[last-1])
  rescue Exception => e
    puts e
    retry
  end
  
  @routes << route
  puts "Создан маршрут #{route.first.name} - #{route.last.name}"
end

def main_set_route  #4. Назначить маршрут поезду
  puts 'Выберитe поезд'
  main_trains_list
  train_index = gets.to_i
    
  puts 'Выберитe маршрут'
  main_routes_list
  route_index = gets.to_i
    
  unless (1..@trains.size).include?(train_index) && (1..@routes.size).include?(route_index)
    puts "Введите правильные цифры"
  else
    train = @trains[train_index-1]
    route = @routes[route_index-1]
    train.set_route(route)
    puts "Поезд номер #{train.num} поедет по маршруту #{route.first.name} - #{route.last.name}"
  end 
end

def main_route_add_station  #5. Добавить станцию в маршрут
  puts 'Выберитe маршрут'
  main_routes_list
  route_index = gets.to_i

  puts 'Какую станцию добавить'
  main_stations_list
  station_index = gets.to_i

  unless (1..@stations.size).include?(station_index) && (1..@routes.size).include?(route_index)
    puts "Введите правильные цифры"
  else
    route = @routes[route_index-1]
    station = @stations[station_index-1]
    route.add_station(station)
    puts "Станция #{station.name} добавлена в маршрут #{route.first.name} - #{route.last.name}"
  end  
end

def main_route_delete_station  #6. Удалить станцию из маршрута
  puts 'Выберитe маршрут'
  main_routes_list
  route_index = gets.to_i

  puts 'Какую станцию удалить'
  @routes[route_index-1].list_stations
  station_index = gets.to_i

  unless (1..@stations.size).include?(station_index) && (1..@routes.size).include?(route_index)
    puts "Введите правильные цифры"
  else
    route = @routes[route_index-1]
    station = @stations[station_index-1]
    route.delete_station(station)
    puts "Станция #{station.name} удалена из маршрута #{route.first.name} - #{route.last.name}"
  end 
end

def main_add_carriage  #7. Добавить вагон к поезду
  puts 'Выберитe поезд'
  main_trains_list
  train_index = gets.to_i
  train = @trains[train_index-1]

  if train.type == :passenger
    puts 'Количество посадочных мест в вагоне?' 
  else
    puts 'Объем вагона?'
  end
  value = gets.to_i

  train.add_carriage(value, train.type)
  puts "В поезд номер #{train.num} добавлен вагон типа #{train.type}"
end

def main_remove_carriage  #8. Отцепить вагон от поезда
  puts 'Выберитe поезд'
  main_trains_list
  train_index = gets.to_i
  train = @trains[train_index-1]

  return puts 'У поезда нет вагонов' if train.carriages.empty?

  train.remove_carriage
  puts "Из поезда номер #{train.num} удален вагон типа #{train.type}"
end

def main_train_move_forward  #9. Перемещать поезд по маршруту вперед
  puts 'Выберите поезд'
  main_trains_on_route_list
  train_index = gets.to_i
  train = @trains_on_route[train_index-1]

  train.move_forward
  puts "Поезд номер #{train.num} проехал вперед на 1 станцию"
end

def main_train_move_backward  #10. Перемещать поезд по маршруту назад
  puts 'Выберите поезд'
  main_trains_on_route_list
  train_index = gets.to_i
  train = @trains_on_route[train_index-1]

  train.move_backward
  puts "Поезд номер #{train.num} проехал назад на 1 станцию"
end

def main_trains_on_station_list  #12. Cписок поездов на станции
  stations_with_trains

  station_index = gets.to_i
  station = @stations[station_index-1]

  station.all_trains_method do |train|
    puts "Поезд номер #{train.num}, тип #{train.type}, кол-во вагонов #{train.carriages.size}"
  end
end

def main_train_carriages_list  #13.  Выводить список вагонов у поезда
  trains_with_carriages

  train_index = gets.to_i
  train = @trains[train_index-1]

  if train.type == :passenger
    @index = 0
    train.all_carriages_method do |carriage|
      puts "Вагон #{@index += 1}. Тип вагона #{carriage.type}, свободных мест #{carriage.empty_seats} занятых мест #{carriage.occupied_seats}"
    end
  else
    @index = 0
    train.all_carriages_method do |carriage|
      puts "Вагон #{@index += 1}. Тип вагона #{carriage.type}, кол-во свободного объема #{carriage.unused_volume} занятого объема #{carriage.occupied_volume}"
    end
  end
end

def main_occupy  #14.  Занимать место или объем в вагоне
  trains_with_carriages

  train_index = gets.to_i
  train = @trains[train_index-1]

  puts 'Выберите вагон'
  @index = 0
  train.all_carriages_method do |carriage|
    puts "Вагон номер #{@index += 1}, Тип вагона #{carriage.type}"
  end

  carriage_index = gets.to_i
  carriage = train.carriages[carriage_index-1]

  if carriage.type == :cargo
    puts "Kол-во свободного объема #{carriage.unused_volume} занятого объема #{carriage.occupied_volume}. Сколько добавить объем?"
    value = gets.to_i

    return puts 'Столько не поместится' if value > carriage.unused_volume

    carriage.occupy_volume(value)
    puts "В вагон добавлено #{value} eдиниц объема. Kол-во свободного объема #{carriage.unused_volume} занятого объема #{carriage.occupied_volume}."
  else
    return puts 'Вагон битком' if carriage.empty_seats == 0

    carriage.occupy_seat
    puts "В вагоне занято одно место. Оставшихся мест #{carriage.empty_seats}" 
  end
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

  when 1  #1. Создать станцию
    main_add_station 
  when 2  #2. Создать поезд
    main_add_train   
  when 3  #3. Создать маршрут 
    main_add_route     
  when 4  #4. Назначить маршрут поезду
    main_set_route 
  when 5  #5. Добавить станцию в маршрут
    main_route_add_station  
  when 6  #6. Удалить станцию из маршрута
    main_route_delete_station
  when 7  #7. Добавить вагон к поезду
    main_add_carriage    
  when 8  #8. Отцепить вагон от поезда
    main_remove_carriage
  when 9  #9. Перемещать поезд по маршруту вперед
    main_train_move_forward       
  when 10 #10. Перемещать поезд по маршруту назад
    main_train_move_backward
  when 11  #11. Просмотреть список станций
    puts 'Список станций'
    main_stations_list  
  when 12  #12. Cписок поездов на станции
    main_trains_on_station_list
  when 13  #13. Выводить список вагонов у поезда
    main_train_carriages_list
  when 14  #14. Занимать место или объем в вагоне
    main_occupy
  when 0
    exit
  end      
end
