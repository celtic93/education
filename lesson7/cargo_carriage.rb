class CargoCarriage < Carriage
  def initialize(value, type = :cargo)
    super
    @occupied_volume = 0
  end

  def occupy_volume(cargo)
    return 'Вагон заполнен' if @occupied_volume == @value
    return "В вагоне осталось #{self.unused_volume} единиц объема" if @occupied_volume + cargo > @value
    @occupied_volume += cargo
  end

  def occupied_volume
    @occupied_volume
  end

  def unused_volume
    @value - @occupied_volume
  end
end
