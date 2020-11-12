module Manufacturer
  attr_reader :manufactorer

  def manufacturer(name)
    self.manufacturer = name.capitalize
  end
end
