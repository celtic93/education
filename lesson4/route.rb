class Route
  attr_reader :stations, :last, :first
  #Имеет начальную и конечную станцию, а также список промежуточных станций. 
  #Начальная и конечная станции указываютсся при создании маршрута,
  #а промежуточные могут добавляться между ними.
  def initialize(first, last)
    @first = first
    @last = last
    @stations = [@first, @last]
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
    index = 1
    @stations.each do |station| 
      puts "#{index} #{station.name}"
      index += 1
    end
  end
end
