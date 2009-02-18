class NotificationController < ApplicationController
  def index
    @notifs = Notification.find_all_by_follower_id(params[:user_id])
    
    
  end
  def show
    
  end
end
