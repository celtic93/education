require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validation'

class Train
  include Manufacturer
  include InstanceCounter
  include Validation
  #Может возвращать количество вагонов
  #Возвращать текущую станцию на основе маршрута
  attr_reader :carriages, :stations, :current_station, :num, :type, :carriages

  #Может возвращать текущую скорость
  #Может набирать скорость
  attr_accessor :speed  

  VALID_NUMBER = /^[a-z\d]{3}-?[a-z\d]{2}$/i

  def self.find(num)
    @@trains.find {|train| train.num == num}
  end

  @@carriages_depot = {:cargo => [], :passenger => []}

  @@trains = []
  #Имеет номер (произвольная строка) и тип (грузовой, пассажирский)
  #и количество вагонов, эти данные указываются при создании экземпляра класса
  def initialize(num, type)      
    @num = num
    @type = type
    validate!
    @speed = 0
    @carriages = []
    @@trains << self
    self.register_instance
  end

  def validate!
    raise 'Неверный формат номера' if num.to_s !~ VALID_NUMBER
    raise 'Неверный тип поезда (cargo или passenger)' unless [:cargo, :passenger].include?(@type)
    raise 'Поезд с таким номером уже есть' if @@trains.map {|train| train.num }.include? @num
    true
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
  def add_carriage(type)
    return 'Остановите поезд!' unless @speed == 0

    if @@carriages_depot[type].empty?
      @carriages << Carriage.new(type)
    else
      carriage = @@carriages_depot[type].last
      @carriages << carriage
      @@carriages_depot[type].delete(carriage)
    end
  end

  def remove_carriage
    return 'Остановите поезд!' unless @speed == 0
    return 'У поезда нет вагонов' if @carriages.empty?
    
    carriage = @carriages.last
    @carriages.delete(carriage)
    @@carriages_depot[self.type] << carriage
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
      return 'Это последняя станция'
    end
  end

  def move_backward
    if @index != 0
      @stations[@index].departure(self)
      @index -= 1
      @current_station = @stations[@index]
      @stations[@index].arrival(self)
    else
      return 'Это первая станция'
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
      return 'Это последняя станция'
    end
  end

  def previous_station
    if @index != 0
      @stations[@index-1]
    else
      return 'Это первая станция'
    end
  end
end
