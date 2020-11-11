class Route
  include InstanceCounter

  attr_reader :stations

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]
    register_instance
  end

  def add_intermediate(station)
    @stations.insert(-2, station)
  end

  def delete_intermediate(station)
    @stations.delete(station) if @stations.include?(station)
  end

  def show_route
    @stations.each { |station| puts station.name }
  end

  private

  attr_writer :stations
end
