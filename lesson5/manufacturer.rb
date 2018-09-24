module Manufacturer
  def set_manufacturer(name)
    self.manufacturer = name
  end

  def get_manufacturer
    self.manufacturer
  end

  protected
  attr_accessor :manufacturer  
end
