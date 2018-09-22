class PassengerTrain < Train
  attr_reader :type

  def initialize(num, type = :passenger)
    super
  end
end
