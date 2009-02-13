class TfassessmentController < ApplicationController

  def index
    if params[:idno]
      @profiles = Tfassessment.find_all_by_idNo params[:idno]
    else
      @profiles = Tfassessment.find(:all)
    end

    render :xml => @profiles.to_xml
  end


  # http://localhost:3000/TFassessments/2061009
  def show
    @profile = Tfassessment.find_by_idNo(params[:id])
    if @profile
      render :xml => @profile.to_xml
    else
      render :xml => Tfassessment.find(2)#pre configured to return a null object kung la sya mahanap...just create a null
                                       #object in the console...
    end
  end
end
