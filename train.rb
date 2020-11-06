class Train
  attr_reader :number, :type, :route
  attr_accessor :speed, :count, :station

  def initialize(number, type, count)
    @number = number
    @type = type
    @count = count
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

  def add_wagon
    if self.speed == 0
      self.count += 1
    else
      puts 'Остановитесь чтобы прицепить вагон'
    end
  end

  def delete_wagon
    if self.speed == 0
      self.count -= 1
    else
      puts 'Остановитесь чтобы отцепить вагон'
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

  def move_next_station
    self.station = route.stations[route.staions.index(staion) + 1]
  end
end
