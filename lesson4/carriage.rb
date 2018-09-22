class Carriage
  attr_reader :carriages_depot, :type

  $carriages_depot = {:cargo => [], :passenger => []}

  def initialize(type)
    @type = type
    $carriages_depot[type] << self 
  end
end
