class AttendanceController < ApplicationController
  def index
    if params[:idno]
      @profiles = Attendance.find_all_by_idNo params[:idno]
    else
      @profiles = Attendance.find(:all)
    end

    render :xml => @profiles.to_xml
  end


  # http://localhost:3000/attendances/2061009
  def show
    @profile = Attendance.find_by_idNo(params[:id])
    if @profile
      render :xml => @profile.to_xml
    else
      render :xml => Attendance.find(2)
    end
  end
end
