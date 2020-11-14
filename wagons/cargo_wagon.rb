class CargoWagon < Wagon
  attr_reader :free_volume, :taken_volume

  def initialize
    super
    @type = :cargo
    @free_volume = volume
    @taken_volume = 0
    validate!
  end

  def take_volume(volume)
    raise 'Занятый объем должен быть числом' unless volume.is_a? Integer
    raise 'Минимальный объем багажного места равен единице' if volume <= 0
    raise 'В вагоне не осталось свободного места' if volume > @free_volume

    @free_volume -= volume
    @taken_volume += volume
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise 'Объем поезда должен быть числом' unless @free_volume.is_a? Integer
    raise 'Объем поезда не может быть отрицательным' if @free_volume < 0
  end
  
end
