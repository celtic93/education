require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'

class Station
  include InstanceCounter
  include Validation
  extend Accessors

  attr_reader :name, :trains

  validate :name, :presence
  validate :name, :type, String

  def self.all
    @@stations
  end

  @@stations = []

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self
    register_instance
  end

  def validate!
    super
    raise 'Такая станция уже есть' if @@stations.map(&:name).include? name
    raise 'Название станции слишком короткое' if name.size < 2

    true
  end

  # Can take trains (one at a time)
  def arrival(train)
    @trains << train
  end

  # May return a list of all trains at a station currently in use.
  def trains_list
    @trains.each_with_index do |train, index|
      puts "#{index}. Поезд номер #{train.num}"
    end
  end

  # Can send trains (one at a time, while
  # the train is removed from the list of trains located at the station).
  def departure(train)
    @trains.delete(train)
  end

  # Can return the list of trains at the station by type (see below):
  # number of freight, passenger
  def trains_type(type)
    @trains.select { |train| train.type == type }
  end

  def all_trains_method
    @trains.each do |train|
      yield(train)
    end
  end
end
