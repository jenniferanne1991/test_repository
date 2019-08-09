require 'test_helper'

class TimesheetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@timesheet = Timesheet.new(start: DateTime.new(2019,8,8,12,00), finish: DateTime.new(2019,8,8,19,30))
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
  	@timesheet.start = DateTime.now
  	@timesheet.finish = DateTime.now - 0.2
  	assert_not @timesheet.valid?
  end

  test "finish time cannot be in future" do
  	@timesheet.start = DateTime.now - 0.2
  	@timesheet.finish = DateTime.now + 0.2
  	assert_not @timesheet.valid?
  end

end
