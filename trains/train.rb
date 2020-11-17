require './modules/manufacturer'
require './modules/instance_counter'
require './modules/validation'

class Train
  include Manufacturer
  include InstanceCounter
  include Validation

  attr_reader :number, :route

  validate :number, :presence
  validate :number, :type, String
  validate :number, :format, /^[\w\d]{3}-?[\w\d]{2}$/

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number)
    @number = number.to_s
    @type = type
    @wagons = wagons
    @speed = 0
    validate!
    @@trains[@number] = self
    register_instance
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
    else
      false
    end
  end

  def delete_wagon(wagon)
    stop
    if @wagons.include?(wagon)
      @wagons.delete(wagon)
      wagon.on_board = false
    else
      false
    end
  end

  def route=(route)
    @route = route
    self.station = self.route.stations.first
  end

  def move_forward
    i = @route.stations.index(@station)
    if i == (@route.stations.size - 1)
      false
    else
      @station = @route.stations[i + 1]
      @station.add_train(self)
    end
  end

  def move_back
    i = @route.stations.index(@station)
    if i.zero?
      false
    else
      @station = @route.stations[i - 1]
      @station.add_train(self)
    end
  end

  def each_wagon(&block)
    if block.arity == 2
      @wagons.each_with_index { |wagon, index| yield index, wagon }
    else
      @wagons.each { |wagon| yield wagon }
    end
  end

  def next_station
    return false unless @route

    i = @route.stations.index(@station)
    last_station = @route.stations.size - 1
    return false if i == last_station

    @route.stations[i + 1]
  end

  def previous_station
    return false unless @route

    i = @route.stations.index(@station)
    return false if i.zero?

    @route.stations[i - 1]
  end

  protected # Переменные и метод, доступ к которым необязателен для юзеров. Все остальное используется в интерфейсе

  attr_accessor :speed, :station, :type, :route, :wagons

  def move_next_station
    self.station = route.stations[route.staions.index(staion) + 1]
  end
end
