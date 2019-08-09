class Timesheet < ApplicationRecord
	validates :start, presence: true
	validates :finish, presence: true

	validate :start_must_be_before_finish, :finish_cannot_be_in_future

	def start_must_be_before_finish
		if start.present? && finish.present? && start >= finish
			errors.add(:finish, "finish must be after start")
		end
	end

	def finish_cannot_be_in_future
		if finish.present? && finish > DateTime.now
			errors.add(:finish, "timesheet entries cannot be in the future")
		end
	end

end
