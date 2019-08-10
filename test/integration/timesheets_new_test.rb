require 'test_helper'

class TimesheetsNewTest < ActionDispatch::IntegrationTest
  
	test "invalid timesheet information" do
		get new_path
		assert_no_difference 'Timesheet.count' do
			post timesheets_path, params: { timesheet: {
				date: Date.tomorrow,
				start: Time.now + 1800,
				finish: Time.now - 1800}   }
		end
		assert_template 'timesheets/new'
	end

end
