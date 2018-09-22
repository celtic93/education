class Train
  #Может возвращать количество вагонов
  #Возвращать текущую станцию на основе маршрута
  attr_reader :carriages, :stations, :current_station, :num, :type, :carriages

  #Может возвращать текущую скорость
  #Может набирать скорость
  attr_accessor :speed  

  #Имеет номер (произвольная строка) и тип (грузовой, пассажирский)
  #и количество вагонов, эти данные указываются при создании экземпляра класса
  def initialize(num, type)      
    @num = num
    @type = type
    @speed = 0
    @carriages = []
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
  def add_carriage(carriage)
    if @speed == 0
      @carriages << carriage
    else
      puts 'Stop the train!'
    end
  end

  def remove_carriage
    return puts 'Stop the train!' unless @speed == 0
    return puts 'No carriages' if @carriages == []
    
    carriage = @carriages.last
    @carriages.delete(carriage)
    $carriages_depot[self.type] << carriage
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

  def on_route?
    true unless @stations == nil
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
