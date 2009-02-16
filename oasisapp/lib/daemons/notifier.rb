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
      @tf_assessment = Tfassessment.find(:all, :from => "/tfassessment/?idno=#{follower.idno}")
      @tf_breakdown = Tfbreakdown.find(:all, :from => "/tfbreakdown/?idno=#{follower.idno}")
               
      if @violations.size>0
        if state.violation_rows  < @violations.size
          state.violation_rows =  @violations.size
          state.save
          notif =  Notification.new
          notif.delivered_at = Time.now
          notif.follower_id = follower.user_id
          notif.idno = follower.idno
          notif.details = "has a violation!"
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
          notif.idno = follower.idno
          notif.details = " has a guidance!"
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
          notif.idno = follower.idno
          notif.details = " has a grades!"
          notif.notification = "grades notice!"
          notif.save
        end
      end

      if @tf_assessment.size >0
        if state.tf_assessment_rows < @tf_assessment.size
          state.tf_assessment_rows = @tf_assessment.size
          state.save
          notif = Notification.new
          notif.delivered_at = Time.now
           notif.idno = follower.idno
          notif.details = " has a assessment!"
          notif.notification = "assessment notice!"
          notif.save

        end
      end

      if  @tf_breakdown.size >0
        if state.tf_assessment_rows <  @tf_breakdownt.size
          state.tf_assessment_rows =  @tf_breakdown.size
          state.save
          notif = Notification.new
          notif.delivered_at = Time.now
           notif.idno = follower.idno
          notif.details = " has a breakdown!"
          notif.notification = "breakdown"
          notif.save

        end
      end

      if @attendance.size >0
        if state.attendance_as_of < @attendance.asOfDate
          state.attendance_as_of = @attendance.asOfDate
          state.save
           notif = Notification.new
          notif.delivered_at = Time.now
           notif.idno = follower.idno
          notif.details = " has a absence!"
          notif.notification = "absence"
          notif.save
        end
      end

        
      ##      update admin variable for next generation
      #dont forget to generate the mails and send the cp messages

    end
      
   
    
  end
  #check every 60 secs if sked update
  sleep 60
end


