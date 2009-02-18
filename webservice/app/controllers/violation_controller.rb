class ViolationController < ApplicationController
  def index
    if params[:idno]
      @profiles = Violation.find_all_by_idNo params[:idno]
    else
      @profiles = Violation.find(:all)
    end

    render :xml => @profiles.to_xml 
  end


  # http://localhost:3000/violations/2061009
  def show
    @profile = Violation.find_by_idNo(params[:id])
    if @profile
      render :xml => @profile.to_xml
    else
      render :xml => Violation.find(2)
    end
  end
end
