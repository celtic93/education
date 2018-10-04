require_relative 'instance_counter'

class Route
  include InstanceCounter
  include Validation

  attr_reader :stations, :last, :first
  #Имеет начальную и конечную станцию, а также список промежуточных станций. 
  #Начальная и конечная станции указываютсся при создании маршрута,
  #а промежуточные могут добавляться между ними.
  def initialize(first, last)
    @first = first
    @last = last
    validate!
    @stations = [@first, @last]
    self.register_instance
  end

  def validate!
    raise 'Названия станций не могут совпадать' if first == last
    true
  end

  #Может добавлять промежуточную станцию в список
  def add_station(station)
    @stations.insert(-2, station)
  end

  #Может удалять промежуточную станцию из списка
  def delete_station(station)
    @stations.delete(station)
  end

  #Может выводить список всех станций по-порядку от начальной до конечной
  def list_stations
    @stations.each_with_index {|station, index| puts "#{index+1} #{station.name}"}
  end
end
