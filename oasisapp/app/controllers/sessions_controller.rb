# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  
  layout 'login'
  # render new.rhtml
  

  def new
    
    
    @IE = case (request.env['HTTP_USER_AGENT']).index('.NET')
    when nil then
      false
    else
      access_denied
      true
    end

    if logged_in?
      redirect_to wards_path
    end
  end

  def create
    if  flash[:login_attempts].nil?
      flash[:login_attempts] =1
    end




    if flash[:login_attempts]  > 6
      session[:lockout] = true
      if session[:lockout_for].nil?
        session[:lockout_for] = 5.minutes.from_now.utc
      else

      end

    end

    if session[:lockout]
      if session[:lockout_for] < Time.now
        #reset session after timer is up
        session[:lockout] = false
        flash[:login_attempts] =1
        session[:lockout_for] = nil
      else
        flash[:notice] = "Max login attempts. Try again later.."
        render :action => 'new'
        return
      end

    end

    self.current_user = User.authenticate(params[:login], params[:password])

    if logged_in?
      if params[:remember_me] == "1"
        current_user.remember_me unless current_user.remember_token?
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      current_user.last_login = current_user.cur_login
      current_user.cur_login = Time.now
      
      current_user.save
      session[:cur_login] = current_user.cur_login
      redirect_to wards_path
      flash[:notice] = "Logged in as #{current_user.login}"
    else
      i = flash[:login_attempts]
      flash[:login_attempts] = i +1
      flash[:notice] = "Invalid username/password. Try again. #{7- flash[:login_attempts] } login attempts left"
      render :action => 'new'
    end
  end

  def destroy
    self.current_user.forget_me if logged_in?
    
    cookies.delete :auth_token
    lang=session[:lang_pref]
    x="You have logged out."
    x =  "You have been logged out because you have signed in from another location.." if session[:another_login] 
    reset_session
    session[:lang_pref]=lang
 flash[:notice] = x

    
    #redirect_to new_session_path
    redirect_to root_path
  end
  
  def set_language
    session[:lang_pref] = params[:lang_pref]
     redirect_to root_path
  end
end
