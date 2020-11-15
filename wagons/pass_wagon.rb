class PassengerWagon < Wagon
  attr_reader :free_seats, :taken_seats

  def initialize(tickets)
    super
    @free_seats = tickets
    @type = :passenger
    @taken_seats = 0
    validate!
  end

  def take_seat
    raise 'Свободных мест нет' if @free_seats.zero?

    @free_seats -= 1
    @taken_seats += 1
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise 'Число мест должно быть числом' unless @free_seats.is_a? Integer
    raise 'Неверное кол-во свободных мест' if @free_seats < 0
    raise 'Неверное кол-во занятых мест' if @taken_seats < 0
  end
end
