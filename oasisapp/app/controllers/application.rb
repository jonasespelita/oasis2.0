# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  before_filter :no_cache, :set_site
  helper :all # include all helpers, all the time
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '0f4c9180aa02a9e2e806a289f8376d03'
  @key = "0f4c9180aa02a9e2e806a289f8376d03"
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

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
