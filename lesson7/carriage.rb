require_relative 'manufacturer'

class Carriage
  include Manufacturer
  include Validation

  attr_reader :type

  def initialize(type)
    @type = type
    validate!
  end

  def validate!
    raise 'Неизвестный тип. Выберите :cargo или :passenger' unless [:cargo, :passenger].include? type 
    true
  end
end
