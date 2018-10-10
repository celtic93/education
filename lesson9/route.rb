require_relative 'instance_counter'

class Route
  include InstanceCounter
  include Validation
  extend Accessors

  attr_reader :stations, :last, :first

  validate :first, :presence
  validate :last, :presence

  def initialize(first, last)
    @first = first
    @last = last
    validate!
    @stations = [@first, @last]
    register_instance
  end

  def validate!
    super
    raise 'Названия станций не могут совпадать' if first == last
  end

  # Can add an intermediate station to the list
  def add_station(station)
    @stations.insert(-2, station)
  end

  # Can remove an intermediate station from the list.
  def delete_station(station)
    @stations.delete(station)
  end

  # It can display a list of all stations in order from initial to final
  def list_stations
    @stations.each_with_index { |station, i| puts "#{i + 1} #{station.name}" }
  end
end
