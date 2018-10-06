require_relative 'carriage'
require_relative 'manufacturer'
require_relative 'validation'

class PassengerCarriage < Carriage
  attr_reader :occupied_seats

  def initialize(value, type = :passenger)
    super
    @occupied_seats = 0
  end

  def occupy_seat
    return 'Все места заняты' if @occupied_seats == @value

    @occupied_seats += 1
  end

  def empty_seats
    @value - @occupied_seats
  end
end
