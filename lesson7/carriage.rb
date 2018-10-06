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
    unless %i[cargo passenger].include? type
      raise 'Неизвестный тип. Выберите :cargo или :passenger'
    end

    true
  end
end
