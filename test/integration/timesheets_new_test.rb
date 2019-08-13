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
		assert_select 'div#error_explanation'
  	assert_select 'div.field_with_errors'
	end

	test "valid timesheet information" do
		get new_path
		assert_difference 'Timesheet.count', 1 do
			post timesheets_path, params: { timesheet:{
				date: Date.new(2000,1,1),
				start: Time.httpdate("Sat, 01 Jan 2000 03:00:00 GMT"),
				finish: Time.httpdate("Sat, 01 Jan 2000 13:30:00 GMT")}	}
		end
		follow_redirect!
		assert_template 'timesheets/index'
		assert Timesheet.last.pay == 493.50
	end

	test "overlapping timesheet entries" do
		Timesheet.create(date: Date.new(2000,1,1), 
			start: Time.httpdate("Sat, 01 Jan 2000 09:00:00 GMT"), 
			finish: Time.httpdate("Sat, 01 Jan 2000 17:00:00 GMT"))
		get new_path
		assert_no_difference 'Timesheet.count' do
			post timesheets_path, params: { timesheet: {
				date: Date.new(2000,1,1),
				start: Time.httpdate("Sat, 01 Jan 2000 07:23:00 GMT"),
				finish: Time.httpdate("Sat, 01 Jan 2000 10:47:00 GMT")}   }
		end
		assert_template 'timesheets/new'
		assert_select 'div#error_explanation'
	end

end
