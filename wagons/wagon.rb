class Wagon
  include Manufacturer

  attr_reader :type
  attr_accessor :on_board

  def initialize(_extra)
    @on_board = false
  end
end
