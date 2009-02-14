class ViolationsController < ApplicationController
  def index
    if params[:idno]
      @profiles = Violations.find_all_by_idno params[:idno]
    else
      @profiles = Violations.find(:all)
    end

    render :xml => @profiles.to_xml # use rail's automatic xml parser to convert object to xml =P
  end


  # http://localhost:3000/profiles/2061009
  def show
    @profile = Violations.find_by_idno(params[:id])
    if @profile
      render :xml => @profile.to_xml
    else
      render :xml => Violations.find(2)
    end
  end
end
