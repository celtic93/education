require_relative 'instance_counter'
require_relative 'validation'

class Station
  include InstanceCounter
  include Validation
  
  attr_reader :name, :trains
  
  def self.all
    @@stations
  end

  @@stations = []
  #Имеет название, которое указывается при ее создании
  def initialize(name) 
    @name = name
    validate!   
    @trains = []
    @@stations << self
    self.register_instance
  end

  def validate!
    raise 'Такая станция уже есть' if @@stations.map {|station| station.name}.include? name
    raise 'Название станции слишком короткое' if name.size < 2
    true
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

  def all_trains_method(&block)
    @trains.each do |train|
      block.call(train)
    end
  end
end
