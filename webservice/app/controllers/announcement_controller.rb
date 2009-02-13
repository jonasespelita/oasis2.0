class AnnouncementController < ApplicationController

  def index
    @profiles = Announcement.find(:all)
    render :xml => @profiles.to_xml # use rail's automatic xml parser to convert object to xml =P
  end


  # http://localhost:3000/announcement/2061009
  def show
    render :xml => Announcement.find(2)
  end
end
