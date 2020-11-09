class Train

  def initialize(number)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
  end

  def train_speed(speed)
    self.speed += speed
    puts "Текущая скорость: #{speed}"
  end

  def stop
    self.speed = 0
    puts "Текущая скорость: #{speed}"
  end

  def add_wagon(wagon)
    stop
    puts 'Поезд остановлен для добавления вагона в состав'
    if wagon.type == @type
      wagons << wagon
      wagon.on_board = true
    else
      puts 'Этот вагон нельзя добавить в состав'
    end
  end

  def delete_wagon(wagon)
    stop
    puts 'Поезд остановлен для удаления вагона из состава'
    if @wagons.include?(wagon)
      @wagons.delete(wagon)
      return wagon.on_board = false
    end
    puts 'Такого вагона нет в составе'
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

  attr_reader :number
  attr_accessor :speed, :station, :type, :route, :wagons

  def move_next_station
    self.station = route.stations[route.staions.index(staion) + 1]
  end
end
