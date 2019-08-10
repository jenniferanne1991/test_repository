require 'test_helper'

class TimesheetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@timesheet = Timesheet.new(date: Date.new(2019,8,8), start: Time.new(2019,8,8,12,00), finish: Time.new(2019,8,8,19,30))
  end

  test "should be valid" do
  	assert @timesheet.valid?
  end

  test "start time must be present" do
  	@timesheet.start = nil
  	assert_not @timesheet.valid?
  end

  test "finish time must be present" do
  	@timesheet.finish = nil
  	assert_not @timesheet.valid?
  end

  test "finish time must be after start" do
    @timesheet.date = Date.today
  	@timesheet.start = Time.now
  	@timesheet.finish = Time.now - 1800
  	assert_not @timesheet.valid?
  end

  test "date cannot be in future" do
  	@timesheet.date = Date.today + 2.days
    @timesheet.start = Time.now - 1800
    @timesheet.finish = Time.now
  	assert_not @timesheet.valid?
  end

end
