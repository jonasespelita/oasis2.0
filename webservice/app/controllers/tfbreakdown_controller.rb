class TfbreakdownController < ApplicationController

  def index
    if params[:idno]
      @profiles = Tfbreakdown.find_all_by_idNo params[:idno]
    else
      @profiles = Tfbreakdown.find(:all)
    end

    render :xml => @profiles.to_xml # use rail's automatic xml parser to convert object to xml =P
  end


  # http://localhost:3000/tfbreakdowns/2061009
  def show
    @profile = Tfbreakdown.find_by_idNo(params[:id])
    if @profile
      render :xml => @profile.to_xml
    else
      render :xml => Tfbreakdown.find(2)#pre configured to return a null object kung la sya mahanap...just create a null
                                       #object in the console...
    end
  end
end
