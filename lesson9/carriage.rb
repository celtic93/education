require_relative 'manufacturer'
require_relative 'validation'
require_relative 'accessors'

class Carriage
  include Manufacturer
  include Validation
  extend Accessors

  attr_reader :type

  validate :type, :presence

  def initialize(value, type)
    @type = type
    @value = value
    validate!
  end

  def validate!
    super
    unless %i[cargo passenger].include? type
      raise 'Неизвестный тип. Выберите :cargo или :passenger'
    end
  end
end
