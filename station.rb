class Station
  include InstanceCounter

  attr_reader :name, :trains

  @@stations = []

  def self.all
    @@stations
  end

  instances

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
  end

  def get_train(train)
    trains << train
  end

  def show_trains
    trains.each do |train|
      puts "Список поездов #{train}"
    end
  end

  def type_trains(type)
    trains.each do |train|
      puts "Тип поезда: #{train}" if train.type == type
    end
  end

  def send_train(train)
    trains.delete(train)
  end
end
