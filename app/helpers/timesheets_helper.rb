module TimesheetsHelper

	def timesheet_params
  		params.require(:timesheet).permit(:date, :start, :finish)
  	end

	# Calculates the value of a timesheet
    def timesheet_value(date_string, start_string, finish_string)
      start_time = Time.parse(start_string.strftime('%I:%M%P'))
      finish_time = Time.parse(finish_string.strftime('%I:%M%P'))
      date = date_string
      dollar_value = 0
      if date.saturday? or date.sunday?
        dollar_value = 47 * (finish_time - start_time) / 1.hours
      elsif date.tuesday? or date.thursday?
        five_am = Time.parse("5:00am")
        five_pm = Time.parse("5:00pm")
        # Calculate time between 5am and 5pm, and 'outside' time
        total_work_time = (finish_time - start_time) / 1.hours
        five_am_to_five_pm_time = time_intersection(start_time, finish_time, five_am, five_pm)
        other_work_time = total_work_time - five_am_to_five_pm_time
        dollar_value = 25 * five_am_to_five_pm_time + 35 * other_work_time
      else
        seven_am = Time.parse("7:00am")
        seven_pm = Time.parse("7:00pm")
        # Calculate time between 7am and 7pm, and 'outside' time
        total_work_time = (finish_time - start_time) / 1.hours
        seven_am_to_seven_pm_time = time_intersection(start_time, finish_time, seven_am, seven_pm)
        other_work_time = total_work_time - seven_am_to_seven_pm_time
        dollar_value = 22 * seven_am_to_seven_pm_time + 33 * other_work_time
      end
      return dollar_value
    end

    def save_timesheet_pay
    	@timesheet.pay = timesheet_value(@timesheet.date, @timesheet.start, @timesheet.finish)
  		@timesheet.save
	end

    private

	    # Given time intervals 'a' and 'b', calculates how much time is common to both intervals
	    def time_intersection(start_a, finish_a, start_b, finish_b)
	      # If one interval finishes before the other starts, intersection is zero.
	      if finish_a < start_b or finish_b < start_a
	        return 0
	      else
	        # Otherwise, intersection goes from the maximum start time to minimum finish time.
	        return ([finish_a, finish_b].min - [start_a, start_b].max) / 1.hours
	      end
	    end

end
