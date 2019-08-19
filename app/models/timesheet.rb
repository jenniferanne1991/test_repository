class Timesheet < ApplicationRecord
	validates :start, presence: true
	validates :finish, presence: true
	validates :date, presence: true

	validate :start_must_be_before_finish
	validate :date_cannot_be_in_future
	validate :timesheet_entries_must_not_overlap

	def date_cannot_be_in_future
		if date.present? && date > Date.today
			errors.add(:date, "can't be in the future")
		end
	end

	def start_must_be_before_finish
		if start.present? && finish.present? && start >= finish
			errors.add(:finish, "time must be after start time")
		end
	end

	def timesheet_entries_must_not_overlap
		same_date_timesheets = Timesheet.where(date: date).where.not(id:self.id)
		if same_date_timesheets == nil
			return
		end
		same_date_timesheets.each do |same_date_timesheet|
			# Given entries have the same date, must ensure one finishes before the other starts
      unless same_date_timesheet.finish < start or finish < same_date_timesheet.start
      	unless errors.added?(:This, "entry overlaps with an exiting timesheet entry")
        	errors.add(:This, "entry overlaps with an exiting timesheet entry")
        end
      end
		end
	end

end
