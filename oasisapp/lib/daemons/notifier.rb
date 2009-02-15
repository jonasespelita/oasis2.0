#!/usr/bin/env ruby

# You might want to change this
ENV["RAILS_ENV"] ||= "development"

require File.dirname(__FILE__) + "/../../config/environment"

$running = true
Signal.trap("TERM") do 
  $running = false
end

while($running) do
  #Change this to admin variable
  set_time = Time.local(2009, "feb", 13, 22, 29)

  if set_time <= Time.now
    Follower.find(:all).each do |follower|
      state = CurrentStateOfFollower.find follower.id
      
      @violations = Violation.find(:all, :from => "/violation/?idno=#{follower.idno}.xml")
      @guidance =  Guidance.find(:all, :from => "/guidance/?idno=#{follower.idno}")
      @attendance= Attendance.find(:last)
      @grades = Grade.find(:all, :from => "/grade/?idno=#{params[:id]}")
      
      
    if state.violation_rows  < @violations.size
        state.violation_rows =  @violations.size
        notif =  new_notif follower.id
        notif.details = "Your ward has a violation!"
        notif.notification = "Violation notice!"
        notif.save
      end
      
      if state.guidance_rows <@guidance.size
        state.guidance_rows =@guidance.size
        notif =  new_notif follower.id
        notif.denotif.details = "Your ward has a guidance!"
        notif.notification = "guidance notice!"
        notif.save  
      end
      
      if state.attendance_as_of < @attendance.asOfDate
        state.attendance_as_of =  @attendance.asOfDate
        notif =  new_notif follower.id
        notif.denotif.details = "Your ward has absences"
        notif.notification = "Attendancenotice!"
        notif.save  
      end
      
      
      if state.grade_rows< @grades.size
        state.attendance_as_of =  @grades.size
         notif =  new_notif follower.id
        notif.denotif.details = "Your ward has grades"
        notif.notification = "Gradsecenotice!"
        notif.save  
      end


##      update admin variable for next generation
#dont forget to generate the mails and send the cp messages
    end
    
    
  end
  #check every 60 secs if sked update
  sleep 60
end

def new_notif(id)
  notif = Notification.new
  notif.follower_id = id
  notif.delivered_at = Time.now
  return notif
end

