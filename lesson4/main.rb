require_relative 'train'
require_relative 'route'
require_relative 'station'
require_relative 'passenger_train'
require_relative 'cargo_train'

stations = []
trains = []

loop do 
  puts 'Выберитe номер команды
    1. Создать станцию
    2. Создать поезд
    3. Создать маршруты и управлять станциями в нем (добавлять, удалять)
    4. Назначить маршрут поезду
    5. Добавить вагон к поезду
    6. Отцепить вагон от поезда
    7. Перемещать поезд по маршруту вперед и назад
    8. Просмотреть список станций и список поездов на станции
    0. Закончить'

  choice = gets.to_i

  case choice
  when 1
    puts 'Введите название станции'
    station_name = gets.chomp
    if stations.map {|station| station.name }.include? station_name
      puts 'Такая станция уже есть'      
    else
      station = Station.new(station_name)
      stations << station
    end
  when 2
    puts 'Введите номер поезда'
    number = gets.to_i
    if trains.map {|train| train.num }.include? number
      puts 'Такой номер уже есть'      
    else
      puts 'Выберитe тип поезда
      1. Пассаржирский
      2. Грузовой'
      type = gets.to_i
      if type == 1
        train = PassengerTrain.new(number)
        trains << train
        trains.each {|x| puts "#{x.num} #{x.type}"}
      elsif type == 2
        train = CargoTrain.new(number)
      else
        puts 'Неверный тип'
      end 
    end
  when 3
  when 4
  when 5
  when 6
  when 7
  when 8
    stations.each {|station| puts station.name}
  when 0
    exit
  end
        
end