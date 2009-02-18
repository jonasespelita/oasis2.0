# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  before_filter :no_cache, :set_site,  :set_locale
  helper :all # include all helpers, all the time
  
  include SimpleCaptcha::ControllerHelpers
  
  def set_locale
    # if this is nil then I18n.default_locale will be used
      if logged_in? 
        session[:lang_pref] = case current_user.lang_pref
        when 1
          "english"
        when 2
          "tagalog"
        end
      end
    
    if session[:lang_pref].nil?
      session[:lang_pref] = "english"
   
      
    end
   
    I18n.locale = session[:lang_pref]
  end

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '0f4c9180aa02a9e2e806a289f8376d03'
  @key = "0f4c9180aa02a9e2e806a289f8376d03"
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  def generate_notifs follower, state

      
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
        notif.new = true
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
        notif.new = true
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
        notif.new = true
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
        notif.new = true
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
        notif.new = true
        notif.save
          
      end
    end
      
    if @attendance.size >0
      last_index = @attendance.size-1
      if state.attendance_as_of < Time.parse(@attendance[last_index].asOfDate)
        state.attendance_as_of = Time.parse(@attendance[last_index].asOfDate)
        state.save
        notif = Notification.new
        notif.delivered_at = Time.now
        notif.idno = follower.idno
        notif.details = " has a absence!"
        notif.notification = "absence"
        notif.new = true
        notif.save
      end
    end

        
    ##      update admin variable for next generation
    #dont forget to generate the mails and send the cp messages

  end
  protected
  def set_site
    site="http://localhost:3000/"
    Violation.site = site
    Profile.site = site
    Grade.site = site
    Attendance.site = site
    Guidance.site = site
    PaymentSchedule.site = site
    Tfbreakdown.site = site
    Tfassessment.site = site
    ClassSchedule.site = site
  end
  
  def no_cache
    response.headers["Last-Modified"] = Time.now.httpdate
    response.headers["Expires"] = -1
    response.headers["Pragma"] = "no-cache"
    response.headers["Cache-Control"] = 'no-store, no-cache, must-revalidate, max-age=0, pre-check=0, post-check=0'
    #it wont work without this ^   O.o
  end
end
