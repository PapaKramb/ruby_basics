require './modules/manufacturer'
require './modules/instance_counter'

class Train
  include Manufacturer
  include InstanceCounter

  attr_reader :number

  def initialize(number)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
  end

  def train_speed(speed)
    self.speed += speed
  end

  def stop
    self.speed = 0
  end

  def add_wagon(wagon)
    stop
    if wagon.type == @type
      wagons << wagon
      wagon.on_board = true
    end
  end

  def delete_wagon(wagon)
    stop
    if @wagons.include?(wagon)
      @wagons.delete(wagon)
      wagon.on_board = false
    end
  end

  def route=(route)
    @route = route
    self.station = self.route.stations.first
  end

  def move_forward
    return if @route.nil?

    station.send_train
    self.station = next_station
    station.get_train
  end

  def move_back
    return if @route.nil?

    station.send_train
    self.station = previous_station
    station.get_train
  end

  def next_station
    route.stations[route.stations.index(station) + 1]
  end

  def previous_station
    route.stations[route.stations.index(station) - 1]
  end

  protected # Переменные и метод, доступ к которым необязателен для юзеров. Все остальное используется в интерфейсе

  attr_accessor :speed, :station, :type, :route, :wagons

  def move_next_station
    self.station = route.stations[route.staions.index(staion) + 1]
  end
end
