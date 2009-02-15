class GuidanceController < ApplicationController
  def index
    if params[:idno]
      @profiles = Guidance.find_all_by_idNo params[:idno]
    else
      @profiles = Guidance.find(:all)
    end

    render :xml => @profiles.to_xml
  end


  # http://localhost:3000/guidances/2061009
  def show
    @profile = Guidance.find_by_idNo(params[:id])
    if @profile
      render :xml => @profile.to_xml
    else
      render :xml => Guidance.find(2)
    end
  end
end
