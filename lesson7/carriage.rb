require_relative 'manufacturer'
require_relative 'validation'

class Carriage
  include Manufacturer
  include Validation

  attr_reader :type

  def initialize(value, type)
    @type = type
    @value = value
    validate!
  end

  def validate!
    raise 'Неизвестный тип. Выберите :cargo или :passenger' unless [:cargo, :passenger].include? type 
    true
  end
end
