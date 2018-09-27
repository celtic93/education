require_relative 'manufacturer'

class Carriage
  include Manufacturer

  attr_reader :carriages_depot, :type

  def initialize(type)
    @type = type
  end
end
