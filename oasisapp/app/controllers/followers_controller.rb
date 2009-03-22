class FollowersController < ApplicationController
  layout 'reg'

  require 'open-uri'

  def new

    #store location so that we can go back if something fails
    store_location
  end
  def change_photo
    @profile = Profile.find params[:id]
    @idno= params[:id]
  end

  def upload_photo
    flash[:notice]= params[:user]
    (Follower.find_all_by_user_id params[:user]).each do |f|
    @profile = Profile.find params[:id]
      if f.idno == params[:id].to_i
        flash[:notice]= "#{t(:rawr)}"
        f .photo = params[:photo]
        if f.save
          flash[:notice] = "Photo Uploaded"
          redirect_to "/oasis/open_sorter"
        else
          flash[:error] = "Invalid File Type"
          render :action=> "change_photo"
        end
      end
    
    end
 
    

  end
  


  
  def create
    if !simple_captcha_valid?
      flash[:error]="#{t(:captcha_error)}"
      redirect_back_or_default('/')
      return
    end
    #check if student exists
    if !verify?(params[:idno], params[:vcode])
      #      open("http://localhost:13004/cgi-bin/sendsms?username=admin&password=Linux&to=#{mobilenum}&text=#{hash(idno)[4..9]}") {|f|}
      redirect_back_or_default('/')
      return
    end
    
   
    #    idno = params[:idno]
    #    vcode = params[:vcode]
    #    mobilenum = params[:mobilenum]

    #init student for easy reference
    stud = Profile.find(params[:idno])

    #adding new ward if logged in
    if logged_in?
      # check if user has already added the ward
      followers = Follower.find_all_by_user_id current_user.id
      followers.each do |f|
        if f.idno.to_s == params[:idno].to_s
          flash[:error]="You are already following #{stud.fullname}"
          redirect_back_or_default('/')
          return
        end
      end

      #all checks done. Time to make follower object
      f = Follower.new
      f.idno = params[:idno]
      f.user_id = current_user.id
      f.position = 10

      if f.save
        #save state of follower for notification generation
        state =  CurrentStateOfFollower.new
        state.attendance_as_of = Time.now
        state.follower_id = f.id
        state.grade_rows=0
        state.guidance_rows=0
        state.violation_rows=0
        state.save

        generate_notifs f, state

        flash[:notice]="You are now following #{stud.fullname}"
      else
        #Unknown error O.o this should never come up
        flash[:error]="Something went wrong...Please try again."
        redirect_back_or_default('/')
      end
      redirect_to wards_path
    else
      #adding ward during registration
      session[:stud_idno] = params[:idno]
      session[:stud_vcode] = params[:vcode]
      redirect_to signup_path
    end
  end


  protected
  
  def hash(i)
    Digest::SHA1.hexdigest("#{@key}#{i}")
  end

  #function to verify idno and vcode
  def verify?(idno, vcode)
    if idno==''|| vcode==''
      flash[:error]="All fields are required."
      return false
    end

    #check if student exists
    begin
      student = Profile.find(idno)
      if student.idNo.nil? #premade Profile for nonexistent students (check web service)
        flash[:error]="The student cannot be found. Please check the ID number and try again."
        return false
      end
    
    
      #need hash formula for vcode verification here!
      if  vcode != hash(idno)[4..9]
        flash[:error]="Invalid Verification Code  #{hash(idno)[4..9]}"
        return false
      end
    rescue
      flash[:error]="The student cannot be found. Please check the ID number and try again."
      return false
    end

    return true
  end

end
