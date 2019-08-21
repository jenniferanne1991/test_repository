class TimesheetsController < ApplicationController
  include TimesheetsHelper

  def new
  	@timesheet = Timesheet.new
  end

  def show
    @timesheet = Timesheet.find(params[:id])
  end

  def index
    @timesheets = Timesheet.all
  end
  
  def create
  	@timesheet = Timesheet.new(timesheet_params)
    # If timesheet saves successfully, calculate pay and list timesheets
  	if @timesheet.save
      save_timesheet_pay
      # List all timesheets.
      redirect_to root_url
  	else
      # If timesheet is not saved, re-render the 'new' page
  		render 'new'
  	end
  end

end
