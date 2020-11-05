class Station
	attr_reader :name
	attr_reader :trains

	def initialize(name)
		@name = name
		@trains = []
	end

	def get_train(train)
		self.trains << train
	end

	def show_trains
		self.trains.each do |train|
			puts "Список поездов #{train}"
		end
	end

	def type_trains(type)
		self.trains.each do |train|
			if train.type == type
				puts "Тип поезда: #{train}"
			end
		end
	end

	def send_train(train)
		self.trains.delete(train)
	end
end