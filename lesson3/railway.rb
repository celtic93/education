class Station
  
  attr_reader :name
  
  #Имеет название, которое указывается при ее создании
  def initialize(name)      
    @name = name
    @trains = []
  end

  #Может принимать поезда (по одному за раз)
  def arrival(train)
    @trains << train
  end

  #Может возвращать список всех поездов на станции, находящиеся в текущий момент
  def trains_list
    @trains    
  end

  #Может отправлять поезда (по одному за раз, при этом,
  #поезд удаляется из списка поездов, находящихся на станции).
  def departure(train)
    @trains.delete(train)    
  end

  #Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
  def trains_type(type)
    @trains.select {|train| train.type == type }
  end
end

class Route
  attr_reader :stations
  #Имеет начальную и конечную станцию, а также список промежуточных станций. 
  #Начальная и конечная станции указываютсся при создании маршрута,
  #а промежуточные могут добавляться между ними.
  def initialize(first, last)
    @first = first
    @last = last
    @stations = [@first, @last]
  end

  #Может добавлять промежуточную станцию в список
  def add(station)
    @stations.insert(-2, station)
  end

  #Может удалять промежуточную станцию из списка
  def delete(station)
    @stations.delete(station)
  end

  #Может выводить список всех станций по-порядку от начальной до конечной
  def list
    @stations.each {|station| puts station.name }
  end
end

class Train
  #Может возвращать количество вагонов
  #Возвращать текущую станцию на основе маршрута
  attr_reader :carriages, :stations, :current_station, :num, :type

  #Может возвращать текущую скорость
  #Может набирать скорость
  attr_accessor :speed, 

  #Имеет номер (произвольная строка) и тип (грузовой, пассажирский)
  #и количество вагонов, эти данные указываются при создании экземпляра класса
  def initialize(num, type, carriages)      
    @num = num
    @type = type
    @carriages = carriages
    @speed = 0
  end

  #Может набирать скорость
  def accelerate
    @speed += 20
  end

  #Может тормозить (сбрасывать скорость до нуля)
  def stop
    @speed = 0
  end

  #Может прицеплять/отцеплять вагоны (по одному вагону за операцию,
  #метод просто увеличивает или уменьшает количество вагонов).
  #Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
  def add_carriage
    if @speed == 0
      @carriages += 1
    else
      puts 'Stop the train!'
    end
  end

  def remove_carriage
    return puts 'Stop the train!' unless @speed == 0
    return puts 'No carriages' if @carriages <= 0
    
    @carriages -= 1
  end

  #Может принимать маршрут следования (объект класса Route). При назначении маршрута
  #поезду, поезд автоматически помещается на первую станцию в маршруте
  def set_route(route)
    @stations[@index].departure(self) if @current_station != nil
    @stations = route.stations
    @index = 0
    @current_station = @stations[@index]
    @stations[@index].arrival(self)
  end

  #Может перемещаться между станциями, указанными в маршруте. 
  #Перемещение возможно вперед и назад, но только на 1 станцию за раз.
  def move_forward
    if @index+1 != @stations.size
      @stations[@index].departure(self)
      @index += 1
      @current_station = @stations[@index]
      @stations[@index].arrival(self)
    else
      puts 'It is the last station'
    end
  end

  def move_backward
    if @index != 0
      @stations[@index].departure(self)
      @index -= 1
      @current_station = @stations[@index]
      @stations[@index].arrival(self)
    else
      puts 'It is the first station'
    end
  end

  #Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
  def current_station
    @current_station
  end
  
  def next_station
    if @index+1 != @stations.size
      @stations[@index+1]
    else
      puts 'It is the last station'
    end
  end

  def previous_station
    if @index != 0
      @stations[@index-1]
    else
      puts 'It is the first station'
    end
  end
end
