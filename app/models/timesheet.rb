class Timesheet < ApplicationRecord
	validates :start, presence: true
	validates :finish, presence: true
	validates :date, presence: true

	validate :start_must_be_before_finish, :date_cannot_be_in_future

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

end
