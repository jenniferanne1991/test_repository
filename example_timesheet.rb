class Timesheet
	attr_accessor :date, :start, :finish

	def initialize(attributes = {})
		@date = attributes[:date]
		@start = attributes[:start]
		@finish = attributes[:finish]
	end

	def formatted_entry
		@date.strftime('%d/%m/%Y: ') + @start.strftime('%I:%M%P - ') + @finish.strftime('%I:%M%P')
	end

end