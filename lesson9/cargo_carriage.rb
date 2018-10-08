require_relative 'carriage'
require_relative 'manufacturer'
require_relative 'validation'

class CargoCarriage < Carriage
  attr_reader :occupied_volume

  def initialize(value, type = :cargo)
    super
    @occupied_volume = 0
  end

  def occupy_volume(cargo)
    return 'Вагон заполнен' if @occupied_volume == @value
    if @occupied_volume + cargo > @value
      return "В вагоне осталось #{unused_volume} единиц объема"
    end

    @occupied_volume += cargo
  end

  def unused_volume
    @value - @occupied_volume
  end
end
