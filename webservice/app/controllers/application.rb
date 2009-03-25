# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include SslRequirement
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '8f80e07990a7ce25bdad35ea95156e28'
  
  
  
  
  before_filter :authenticate
  
  protected
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username=="slu" && password =="slu"
    end
    end
  end

