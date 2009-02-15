#!/usr/bin/env ruby

# You might want to change this
ENV["RAILS_ENV"] ||= "development"

require File.dirname(__FILE__) + "/../../config/environment"

$running = true
Signal.trap("TERM") do 
  $running = false
end

while($running) do
  set_time = Time.local(2009, "feb", 13, 22, 29)
  site="http://localhost:3000/"
  Violation.site = site
  Profile.site = site
  Grade.site = site
  Attendance.site = site
  Guidance.site = site
  PaymentSchedule.site = site
  Tfbreakdown.site = site
  Tfassessment.site = site
  if set_time <= Time.now
    

    
    Follower.find(:all).each do |follower|
      state = CurrentStateOfFollower.find_by_follower_id  follower.id
      
      @violations = Violation.find(:all, :from => "/violation/?idno=#{follower.idno}")
      @guidance =  Guidance.find(:all, :from => "/guidance/?idno=#{follower.idno}")
      @attendance=  Attendance.find(:all, :from => "/attendance/?idno=#{follower.idno}")
      @grades = Grade.find(:all, :from => "/grade/?idno=#{follower.idno}")
      
               
      if @violations.size>0
        if state.violation_rows  < @violations.size
          state.violation_rows =  @violations.size
          state.save
          notif =  Notification.new
          notif.delivered_at = Time.now
          notif.follower_id = follower.user_id
          notif.details = "Your ward has a violation!"
          notif.notification = "Violation notice!"
          notif.save
        end
      end
        
      if @guidance.size>0
        if state.guidance_rows  < @guidance.size
          state.guidance_rows =  @guidance.size
          state.save
          notif =  Notification.new
          notif.delivered_at = Time.now
          notif.follower_id = follower.user_id
          notif.details = "Your ward has a guidance!"
          notif.notification = "guidace notice!"
          notif.save
        end
      end
        
      if @grades.size>0
        if state.grade_rows  < @grades.size
          state.grade_rows =  @grades.size
          state.save
          notif =  Notification.new
          notif.delivered_at = Time.now
          notif.follower_id = follower.user_id
          notif.details = "Your ward has a grades!"
          notif.notification = "grades notice!"
          notif.save
        end
      end
        
  
    end
      
   
    
  end
  sleep 60
end


