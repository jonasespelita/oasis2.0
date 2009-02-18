class ClassScheduleController < ApplicationController

  def index
    if params[:idno]
      @profiles = ClassSchedule.find_all_by_idNo params[:idno]
    else
      @profiles = ClassSchedule.find(:all)
    end

    render :xml => @profiles.to_xml # use rail's automatic xml parser to convert object to xml =P
  end


  # http://localhost:3000/classschedules/2061009
  def show
    @profile = ClassSchedule.find_by_idNo(params[:id])
    if @profile
      render :xml => @profile.to_xml
    else
      @profile = ClassSchedule.new
      render :xml => @profile #pre configured to return a null object kung la sya mahanap...just create a null
                                       #object in the console...
    end
  end
end
