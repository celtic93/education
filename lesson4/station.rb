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
    @trains.each_with_index {|train, index| puts "#{index}. Поезд номер #{train.num}"}  
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
