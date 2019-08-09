class Timesheet
	attr_accessor :start, :finish

	def initialize(attributes = {})
		@start = attributes[:start]
		@finish = attributes[:finish]
	end

	def formatted_entry
		@start.strftime('%d/%m/%Y: %I:%M%P') + ' - ' + @finish.strftime('%I:%M%P')
	end

end