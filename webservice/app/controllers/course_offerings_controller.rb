class CourseOfferingsController < ApplicationController

  def index
    if params[:endSchYr]
      @profiles = CourseOfferings.find_all_by_endSchYr params[:endSchYr]
      @profiles.delete_if { |p|
        p.semester.to_s!=params[:semester]
      }
    else
      @profiles = CourseOfferings.find(:all)
    end

    render :xml => @profiles.to_xml # use rail's automatic xml parser to convert object to xml =P
  end


  # http://localhost:3000/courseofferings/2061009
  def show
    @profile = CourseOfferings.find_by_endSchYr(params[:endSchYr])
    if @profile
      render :xml => @profile.to_xml
    else
      render :xml => CourseOfferings.find(3)#pre configured to return a null object kung la sya mahanap...just create a null
                                       #object in the console...
    end
  end
end
