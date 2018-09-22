class PassengerCarriage < Carriage
  attr_reader :type
  
  def initialize(type = :passenger)
    super
  end
end
