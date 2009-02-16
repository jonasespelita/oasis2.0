class FollowersController < ApplicationController
  layout 'reg'

  require 'open-uri'

  def new


    #store location so that we can go back if something fails
    store_location
  end

  def upload_photo
     flash[:notice]= params[:user]
    (Follower.find_all_by_user_id params[:user]).each do |f|

      if f.idno == params[:id].to_i
flash[:notice]= "ASDFASDFSADF"
        f .photo = params["pic_#{params[:id]}"]
        f.save
      end
    end



  end
  #function to verify idno and vcode
  def verify?(idno, vcode)
    if idno==''|| vcode==''
      flash[:error]="All fields are requiredblank."
      return false
    end

    #check if student exists
    student = Profile.find(idno)
    if student.id==3 #premade Profile for nonexistent students (check web service)
      flash[:error]="The student cannot be found. Please check the ID number and try again."
      return false
    end

    #need hash formula for vcode verification here!
    if  vcode != hash(idno)[4..9]
      flash[:error]="Invalid Verification Code #{hash(idno)[4..9]}"
      return false
    end


    return true
  end

  def hash(i)
     Digest::SHA1.hexdigest("#{@key}#{i}")
  end

  def create
    idno = params[:idno]
    vcode = params[:vcode]
    mobilenum = params[:mobilenum]
    if !verify?(params[:idno], params[:vcode])
      open("http://localhost:13004/cgi-bin/sendsms?username=admin&password=Linux&to=#{mobilenum}&text=#{hash(idno)[4..9]}") {|f|}
      redirect_back_or_default('/')
      return
    end
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




end
