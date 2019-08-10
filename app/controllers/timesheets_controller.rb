class TimesheetsController < ApplicationController
  def new
  	@timesheet = Timesheet.new
  end

  def show
    @timesheet = Timesheet.find(params[:id])
  end

  def create
  	@timesheet = Timesheet.new(timesheet_params)
  	if @timesheet.save
  		redirect_to @timesheet
  	else
  		render 'new'
  	end
  end

  private

  	def timesheet_params
  		params.require(:timesheet).permit(:date, :start, :finish)
  	end

end
