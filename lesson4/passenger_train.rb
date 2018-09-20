class PassengerTrain < Train
  def initialize(num)
    super
    @type = :passenger
  end
end