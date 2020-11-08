class Wagon
  attr_reader :type
  attr_accessor :on_board

  def initialize
    @on_board = false
    puts 'Создан вагон'
  end
end
