require_relative 'train'
require_relative 'route'
require_relative 'station'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'carriage'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'

@stations = []
@trains = []
@routes = []

def main_trains_list
  index = 1
   @trains.each do |train|
    puts "#{index}. Поезд номер #{train.num}"
    index += 1
  end
end

def main_stations_list
  index = 1
  @stations.each do |station|
    puts "#{index}. #{station.name}"
    index += 1
  end
end

def main_trains_on_route_list
  index = 1
  @trains_on_route = @trains.select {|train| train.on_route?}
  @trains_on_route.each do |train|
    puts "#{index}. Поезд номер #{train.num}"
    index += 1
  end
end

def main_routes_list
  index = 1
  @routes.each do |route|
    puts "#{index}. Маршрут #{route.first.name} - #{route.last.name}"
    index += 1
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
    0. Закончить'

  choice = gets.to_i

  case choice

  when 1  #1. Создать станцию
    puts 'Введите название станции'
    station_name = gets.chomp
    if @stations.map {|station| station.name }.include? station_name
      puts 'Такая станция уже есть'      
    else
      station = Station.new(station_name)
      @stations << station
      puts "Создана станция #{station.name}"
    end    

  when 2  #2. Создать поезд
    puts 'Введите номер поезда'
    num = gets.to_i
    if @trains.map {|train| train.num }.include? num
      puts 'Такой номер уже есть'      
    else
      puts 'Выберитe тип поезда
      1. Пассаржирский
      2. Грузовой'
      type = gets.to_i
      if type == 1
        train = PassengerTrain.new(num)
        @trains << train
        puts "Создан поезд #{train.num}"
      elsif type == 2
        train = CargoTrain.new(num)
        @trains << train
        puts "Создан поезд #{train.num}"
      else
        puts 'Неверный тип'
      end 
    end    

  when 3  #3. Создать маршрут 
    puts 'Выберитe начальную и конечную станции маршрута'
    main_stations_list
    first = gets.to_i
    last = gets.to_i

    if first == last
      puts "Одна станция не может быть конечной и начальной"
    elsif (1..@stations.size).include?(first) && (1..@stations.size).include?(last) == false
      puts "Введите правильные цифры"
    else
      route = Route.new(@stations[first-1], @stations[last-1])
      @routes << route
      puts "Создан маршрут #{route.first.name} - #{route.last.name}"
    end      

  when 4  #4. Назначить маршрут поезду
    puts 'Выберитe поезд'
    main_trains_list
    train = gets.to_i
    
    puts 'Выберитe маршрут'
    main_routes_list
    route = gets.to_i
    
    unless (1..@trains.size).include?(train) && (1..@routes.size).include?(route)
      puts "Введите правильные цифры"
    else
      train = @trains[train-1]
      route = @routes[route-1]
      train.set_route(route)
      puts "Поезд номер #{train.num} поедет по маршруту #{route.first.name} - #{route.last.name}"
    end    

  when 5  #5. Добавить станцию в маршрут
    puts 'Выберитe маршрут'
    main_routes_list
    route = gets.to_i

    puts 'Какую станцию добавить'
    main_stations_list
    station = gets.to_i

    unless (1..@stations.size).include?(station) && (1..@routes.size).include?(route)
      puts "Введите правильные цифры"
    else
      route = @routes[route-1]
      station = @stations[station-1]
      route.add_station(station)
      puts "Станция #{station.name} добавлена в маршрут #{route.first.name} - #{route.last.name}"
    end    

  when 6  #6. Удалить станцию из маршрута
    puts 'Выберитe маршрут'
    main_routes_list
    route = gets.to_i

    puts 'Какую станцию удалить'
    @routes[route-1].list_stations
    station = gets.to_i

    unless (1..@stations.size).include?(station) && (1..@routes.size).include?(route)
      puts "Введите правильные цифры"
    else
      route = @routes[route-1]
      station = @stations[station-1]
      route.delete_station(station)
      puts "Станция #{station.name} удалена из маршрута #{route.first.name} - #{route.last.name}"
    end 

  when 7  #7. Добавить вагон к поезду
    puts 'Выберитe поезд'
    main_trains_list
    train = gets.to_i
    train = @trains[train-1]

    train.type == :cargo ? carriage = CargoCarriage.new : carriage = PassengerCarriage.new
    train.add_carriage(carriage)

    puts "В поезд номер #{train.num} добавлен вагон типа #{carriage.type}"
    
  when 8  #8. Отцепить вагон от поезда
    puts 'Выберитe поезд'
    main_trains_list
    train = gets.to_i
    train = @trains[train-1].type

    train.remove_carriage
    puts "Из поезда номер #{train.num} удален вагон типа #{carriage.type}"

  when 9  #9. Перемещать поезд по маршруту вперед
    puts 'Выберите поезд'
    main_trains_on_route_list
    train = gets.to_i
    train = @trains_on_route[train-1]

    train.move_forward
    puts "Поезд номер #{train.num} проехал вперед на 1 станцию"
       
  when 10 #10. Перемещать поезд по маршруту назад
    puts 'Выберите поезд'
    main_trains_on_route_list
    train = gets.to_i
    train = @trains_on_route[train-1]

    train.move_backward
    puts "Поезд номер #{train.num} проехал назад на 1 станцию"

  when 11  #11. Просмотреть список станций
    puts 'Список станций'
    main_stations_list
  
  when 12  #12. Cписок поездов на станции
    puts 'Выберите станцию'
    main_stations_list
    station = gets.to_i

    @stations[station-1].trains_list
  when 0
    exit
  end
        
end