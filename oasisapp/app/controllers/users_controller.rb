class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead

  layout 'reg'

  # render new.rhtml
  def new
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session


    @user = User.new(params[:user])
    @user.save
    if @user.errors.empty?
      self.current_user = @user
      
      f = Follower.new
      f.idno = session[:stud_idno]
      f.user_id = @user.id
      f.position = 10

      if f.save
        #save state of follower for notification generation
        state =  CurrentStateOfFollower.new
        state.attendance_as_of = Time.now
        state.follower_id = f.id
        state.grade_rows=100
        state.guidance_rows=0
        state.violation_rows=0
        state.save
         generate_notifs f, state
      profile = Profile.find(session[:stud_idno])
      flash[:notice] = "#{profile.fullname}"
      render :action => "finish"
    else
      render :action => "new"
    end
  end
  end
  def finish
    
  end
  def change_password
    @user = current_user
    @old = params[:old_password]
    @lang = case current_user.lang_pref
    when 1
     "<option selected='selected'>English</option> <option>Filipino</option>"
    when 2
      "<option>English</option> <option selected='selected'>Filipino</option>"
    end

    @checkemail = current_user.email_pref
    @checkcp = current_user.mobile_pref
  end

  def change_password_update
    if User.authenticate(current_user.login, params[:old_password])
      if ((params[:password] == params[:password_confirmation]) && !params[:password_confirmation].blank?)
        current_user.password_confirmation = params[:password_confirmation]
        current_user.password = params[:password]

        if current_user.save
          flash[:alert] = "Password successfully changed"
        else
          flash[:alert] = "Password not changed"
        end

      else
        flash[:alert] = "New Password mismatch"
      end
    else
      flash[:alert] = "Old password incorrect"
    end

    respond_to do |format|
      format.html{render :action => 'change_password'}
      format.js
      
    end
  end

  def change_profile_update
    current_user.nickname = params[:n_name]
    current_user.address = params[:address]

    if current_user.save
      flash[:name_alert] = "Profile Updated!"
    else
      flash[:name_alert] = "Invalid inputs."
    end
    respond_to do |format|
      format.js
    end
  end

  def change_email
    current_user.email = params[:email]
    current_user.cp_number = params[:cp]
    current_user.lang_pref = 2
    current_user.mobile_pref = params[:val2]
    current_user.email_pref = params[:val1]
#      case params[:lang]
#    when "English"
#      1
#    when "Filipino"
#      2
#    end
    
    if current_user.save
      flash[:e_alert] = "Settings successfully updated"
    else
      flash[:e_alert] = "Invalid Input."
    end
    respond_to do |format|
      format.js
    end
  end


  def show
    
  end


  ## validation methods
  def vlogin
    if !("#{params[:login]}" =~ /\A[A-Za-z_0-9]*\Z/)
      render :text => "Special characters are not allowed."
      return
    end

    if "#{params[:login]}".length==0
      render :text => "Your desired username."
      return
    end
    if "#{params[:login]}".length < 6
      render :text => "Username is too short. Use 6 to 32 characters"
      return
    end
      
    if(User.find_by_login params[:login]  )
   
      render :text => "Username already taken."
        
    else
    
      render :text =>"<div class='OkNa'>Ok!</div>"
    end
  end


  def vpassword
    session[:password] = params[:password]
    if("#{params[:password]}".length >=6)
      
      render :text => "<div class='OkNa'>Ok!</div>"
    else
      render :text => "Use 6 to 32 characters, no spaces."
    end

  end

  def vconfirm_password

    if "#{params[:confirm_password]}".length == 0
      render :text => "Please enter your chosen password again."
      
    else
      render :text => "Capitalization matters!"
    end
  end

  def vemail
    if params[:email] =~ /(.+)@(.+)\.(.{3})/
      if !User.find_by_email(params[:email])
        render :text => "<div class='OkNa'>Ok!</div>"
      else
        render :text => "Email has already been registered. Choose another."
      end

    else
      if "#{params[:email]}".length==0
        render:text => ""
        return
      end
      render :text => "Invalid Email address."
    end
  end
  def vname
    if !("#{params[:name]}" =~ /\A[A-Za-z\s]*\Z/)
      render :text => "Special characters are not allowed."
      return
    else
      if "#{params[:name]}".length!=0
        render :text => "<div class='OkNa'>Ok!</div>"
      else
        render :text => ""
      end
    end
  end

  def vnickname
    if !("#{params[:nickname]}" =~ /\A[A-Za-z\-\s]*\Z/)
      render :text => "Special characters are not allowed."
      return
    else
      if "#{params[:nickname]}".length < 2
        render :text => "Nickname is too short. Use 2 or more characters."
        return
      end
      if "#{params[:nickname]}".length!=0
        render :text => "<div class='OkNa'>Ok!</div>"
      else
        render :text => ""
      end
    end
  end

  def vcp_number
    if "#{params[:cp_number]}".length ==0;
      render :text => ""
      return
    end
    if params[:cp_number] =~ /\A([\+]?(63[0-9]{10}\Z)|(0[0-9]{10})*\Z)/
      render :text => "<div class='OkNa'>Ok!</div>"
    else
     
      render :text => "Invalid mobile number."
    end

  end

  def vaddress
    if !("#{params[:address]}" =~ /\A[A-Za-z_0-9\s\#.\-]*\Z/)
      render :text=> "Invalid address."
    else
      if "#{params[:address]}".length == 0
        render :text => "Enter your home address."
        return
      end
      render :text => "<div class='OkNa'>Ok!</div>"
    end
  end

  def vold_password
    if current_user.authenticated? params[:password]
      render :text => "<div class='OkNa'>Ok!</div>"

    else
      render :text =>"Your old password"
    end

  end

  def reset_password

  end

  def go_reset_password
     redirect_to root_path
    UserMailer.deliver_forgot_password_mail params[:email], ActiveSupport::SecureRandom.base64(6)
    flash[:notice] ="Email has been sent!"

  end
end