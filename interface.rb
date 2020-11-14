require_relative 'trains/train'
require_relative 'wagons/wagon'
require_relative 'trains/passenger_train'
require_relative 'wagons/pass_wagon'
require_relative 'trains/cargo_train'
require_relative 'wagons/cargo_wagon'
require_relative 'route'
require_relative 'station'
require_relative './modules/manufacturer'
require_relative './modules/instance_counter'

class Interface
  ERROR = 'Похоже что-то пошло не так'.freeze

  def init_interface
    loop do
      puts '1. Создать станцию'
      puts '2. Создать поезд'
      puts '3. Создать маршрут'
      puts '4. Добавить станцию к маршруту'
      puts '5. Убрать станцию из маршрута'
      puts '6. Назначить маршрут для поезда'
      puts '7. Создать вагон'
      puts '8. Изменить состав вагона'
      puts '9. Переместить поезд'
      puts '10. Показать список станций'
      puts '11. Показать список поездов'
      puts '12. Показать список поездов на станции'
      puts 'Для выхода введите "exit"'
      val = gets.chomp
      break if val == 'exit'

      choice(val.to_i)
    end
  end

  def choice(value)
    case value
    when 1 then create_station
    when 2 then create_train
    when 3 then create_route
    when 4 then add_station
    when 5 then delete_station
    when 6 then add_route
    when 7 then create_wagon
    when 8 then train_change
    when 9 then move_train
    when 10 then show_stations
    when 11 then show_trains
    when 12 then show_trains_on_station
    end
  end

  private # Не является клиентским кодом

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end

  def create_station
    puts 'Название станции'
    name = gets.chomp
    @stations << Station.new(name)
    puts "Сегодня была открыта станция #{name}"
  rescue StandardError => e
    puts e.message
    retry
  end

  def create_train
    puts 'Введите название поезда в формате ***-**'
    number = gets.chomp
    puts '1. Пассажирский поезд'
    puts '2. Грузовой поезд'
    type = gets.to_i
    raise 'Введите 1 или 2' if (type != 1) && (type != 2)

    case type
    when 1 then @trains << PassengerTrain.new(number)
    when 2 then @trains << CargoTrain.new(number)
    else create_train
    end
  rescue StandardError => e
    puts e.message
    retry
  end

  def create_route
    return puts 'Слишком мало станций, создайте еще' if @stations.size < 2

    puts 'Введите сначала порядковый номер первой станции, а затем конечной'
    first = gets.to_i - 1
    last = gets.to_i - 1
    return @routes << Route.new(@stations[first], @stations[last]) if @stations[first] && @stations[last]

    puts "Создан маршрут из #{start_station.name} в #{finish_station.name}"
  rescue StandardError => e
    puts e.message
    retry
  end

  def add_station
    puts 'Введите порядковый номер маршрута'
    index_route = gets.to_i - 1
    return puts 'Нет доступных маршрутов' if @routes.empty?
    return puts 'Нет такого маршрута' unless @routes[index_route]

    puts 'Введите порядковый номер станции'
    index_station = gets.to_i - 1
    return @routes[index_route].add_intermediate(@stations[index_station]) if @stations[index_station]

    puts "Станция #{station.name} добавлена в маршрут следования"

  rescue StandardError => e
    puts e.message
    retry
  end

  def delete_station
    puts 'Введите порядковый номер маршрута'
    index_route = gets.to_i - 1
    return puts 'Нет доступных маршрутов' if @routes.empty?
    return puts 'Нет такого маршрута' unless @routes[index_route]

    puts 'Введите порядковый номер станции'
    index_station = gets.to_i - 1
    return @routes[index_route].delete_intermediate(@stations[index_station]) if @stations[index_station]

    puts "Станция #{station.name} убрана из маршрута следования"

  rescue StandardError => e
    puts e.message
    retry
  end

  def add_route
    puts 'Введите порядковый номер поезда, а затем порядковый номер маршрута'
    index_train = gets.to_i - 1
    index_route = gets.to_i - 1
    return puts 'Нет доступных маршрутов' if @routes.empty?
    return puts 'Нет такого маршрута' unless @routes[index_route]
    return @trains[index_train].add_route(@routes[index_route]) if @trains[index_train]

    puts ERROR
  end

  def create_wagon
    puts '1. Пассажирский'
    puts '2. Грузовой'
    type = gets.to_i
    return @wagons << PassengerWagon.new if type == 1
    return @wagons << CargoWagon.new if type == 2
    raise 'Введите 1 или 2' if (type != 1) && (type != 2)

    if type == 1
      puts 'Введите объем грузового вагона'
      volume = gets.to_i
      @wagons << CargoWagon.new(volume)
    else
      puts 'Введите кол-во мест в вагоне'
      tickets = gets.to_i
      @wagons << PassengerWagon.new(tickets)
    end
  rescue StandardError => e
    puts e.message
  end

  def train_change
    puts '1. Прицепить вагон'
    puts '2. Отцепить вагон'
    val = gets.to_i
    puts 'Введите сначала порядковый номер вагона, а затем порядковый номер поезда'
    index_wagon = gets.to_i - 1
    index_train = gets.to_i - 1
    if @trains[index_train] && @wagons[index_wagon]
      return @trains[index_train].add_wagon(@wagons[index_wagon]) if val == 1
      return @trains[index_train].delete_wagon(@wagons[index_wagon]) if val == 2
    end
    puts ERROR
  end

  def move_train
    puts 'Введите порядковый номер поезда'
    index_train = gets.to_i - 1
    return puts 'Поезд не существует' unless @trains[index_train]
    return puts 'У поезда не задан маршрут' unless @trains[index_train].route

    puts '1. Двигаться вперёд'
    puts '2. Вернуться назад'
    val = gets.to_i
    return @trains[index_train].move_forward if val == 1
    return @trains[index_train].move_back if val == 2

    puts ERROR
  end

  def show_stations
    @stations.each_with_index { |station, i| puts "#{station.name} Номер: #{i + 1}" }
  end

  def show_trains
    @trains.each_with_index { |train, i| puts "#{train.number} Номер: #{i + 1}" }
  end

  def show_trains_on_station
    station = choice_station
    station.each_train { |train, i| puts "#{i + 1}. #{train.number}" }
  end

  def show_wagons_in_train
    train = choice_station
    if train.type == :cargo
      train.each_wagon do |i, c|
        puts "#{i + 1}: Грузовой #{c.free_volume}/#{c.taken_volume}"
      end
    else
      train.each_wagon do |i, c|
        puts "#{i + 1}: Пассажирский #{c.free_seats}/#{c.taken_seats}"
      end
    end
  end
  
  def choice_train
    puts 'Введите порядковый номер поезда'
    index_train = gets.to_i - 1
    raise 'Порядковый номер должен быть числом' unless index_train.is_a? Integer
    raise 'Порядковый номер не может быть меньше 1' if index_train < 0
    raise 'Поезд не существует' unless @trains[index_train]
  
    @trains[index_train]
  end
  
  def choice_station
    puts 'Введите порядковый номер станции'
    index_station = gets.to_i - 1
    raise 'Порядковый номер должен быть числом' unless index_station.is_a? Integer
    raise 'Порядковый номер не может быть меньше 1' if index_station < 0
    raise 'Станция не существует' unless @stations[index_station]
  
    @stations[index_station]
  end
  
  def choice_route
    raise 'Нет доступных маршрутов' if @routes.empty?
  
    puts 'Введите порядковый номер маршрута'
    index_route = gets.to_i - 1
    raise 'Порядковый номер должен быть числом' unless index_route.is_a? Integer
    raise 'Порядковый номер не может быть меньше 1' if index_route < 0
    raise 'Маршрут не существует' unless @routes[index_route]
  
    @routes[index_route]
  end
end
