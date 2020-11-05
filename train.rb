class Train
	attr_reader :number
	attr_reader :type
	attr_reader :route
	attr_accessor :speed
	attr_accessor :count
	attr_accessor :station

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
  		puts "Остановитесь чтобы прицепить вагон"
  	end
  end

	def delete_wagon
  	if self.speed == 0
  		self.count -= 1
  	else
  		puts "Остановитесь чтобы отцепить вагон"
  	end
  end 

  def route=(route)
    @route = route
    self.station = self.route.stations.first
  end 

  def next_station
  	self.route.stations[self.route.stations.index(self.station) + 1]
  end

  def previous_station
  	self.route.stations[self.route.stations.index(self.station) - 1]
  end

  def move_next_station
  	self.station = self.route.stations[self.route.staions.index(self.staion) + 1]
  end
end