class CargoCarriage < Carriage
  attr_reader :type

  def initialize
    super
    @type = :cargo
  end
end