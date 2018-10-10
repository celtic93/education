require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'
require_relative 'accessors'

class Train
  include Manufacturer
  include InstanceCounter
  include Validation
  extend Accessors

  VALID_NUMBER = /^[a-z\d]{3}-?[a-z\d]{2}$/i
  # Return current station based on route
  attr_reader :carriages, :stations, :current_station, :num, :type
  # Return current speed
  # Can gain speed
  attr_accessor :speed

  validate :type, :presence
  validate :num, :format, VALID_NUMBER

  @@carriages_depot = { cargo: [], passenger: [] }

  @@trains = []

  def initialize(num, type)
    @num = num
    @type = type
    validate!
    @speed = 0
    @carriages = []
    @@trains << self
    register_instance
  end

  def self.find(num)
    @@trains.find { |train| train.num == num }
  end

  def validate!
    super
    raise 'Неверный формат номера' if num.to_s !~ VALID_NUMBER
    unless %i[cargo passenger].include?(@type)
      raise 'Неверный тип поезда (cargo или passenger)'
    end
    @validate_index ||= 0
    if @validate_index == 0
      @validate_index += 1
      raise 'Поезд с таким номером уже есть' if @@trains.map(&:num).include? @num
    end
  end

  # Can gain speed
  def accelerate
    @speed += 20
  end

  # Can brake (reset speed to zero)
  def stop
    @speed = 0
  end

  # Can hook / unhook carriages (one carriage for each operation,
  # method simply increases or decreases the number of cars).
  # Coupling / uncoupling of carriages can be carried
  # out only if the train is not moving.
  def add_carriage(value, type)
    return 'Остановите поезд!' unless @speed.zero?

    if @@carriages_depot[type].empty?
      new_carriage(value)
    else
      carriage = @@carriages_depot[type].last
      @carriages << carriage
      @@carriages_depot[type].delete(carriage)
    end
  end

  def remove_carriage
    return 'Остановите поезд!' unless @speed.zero?
    return 'У поезда нет вагонов' if @carriages.empty?

    carriage = @carriages.last
    @carriages.delete(carriage)
    @@carriages_depot[type] << carriage
  end

  # It can take a route (object of class Route). Upon appointment
  # route of the train, the train is automatically
  # placed on the first station in the route
  def add_route(route)
    @stations[@index].departure(self) unless @current_station.nil?
    @stations = route.stations
    @index = 0
    @current_station = @stations[@index]
    @stations[@index].arrival(self)
  end

  def on_route?
    true unless @stations.nil?
  end

  # Can move between stations indicated in the route.
  # Moving is possible back and forth, but only 1 station at a time.
  def move_forward
    raise 'Это последняя станция' if @stations[@index + 1].nil?

    @stations[@index].departure(self)
    @index += 1
    @current_station = @stations[@index]
    @stations[@index].arrival(self)
  end

  def move_backward
    raise 'Это первая станция' if @index.zero?

    @stations[@index].departure(self)
    @index -= 1
    @current_station = @stations[@index]
    @stations[@index].arrival(self)
  end

  # Return the previous station following, based on the route
  def next_station
    if @index + 1 != @stations.size
      @stations[@index + 1]
    else
      'Это последняя станция'
    end
  end

  def previous_station
    if @index != 0
      @stations[@index - 1]
    else
      'Это первая станция'
    end
  end

  def all_carriages_method
    @carriages.each do |carriage|
      yield(carriage)
    end
  end

  private

  def new_carriage(value)
    @carriages <<
      if type == :cargo
        CargoCarriage.new(value)
      else
        PassengerCarriage.new(value)
      end
  end
end
