class CargoTrain < Train
  attr_reader :type
  
  def initialize(num, type = :cargo)
    super
  end
end
