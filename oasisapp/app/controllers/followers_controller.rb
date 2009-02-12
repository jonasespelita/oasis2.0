class FollowersController < ApplicationController
  layout 'reg'

  def new
    
    
    #store location so that we can go back if something fails
    store_location
  end

  #function to verify idno and vcode
  def verify?(idno, vcode)
    if idno==''|| vcode==''
      flash[:error]="Fields cannot be blank."
      return false
    end

    #check if student exists
    student = Profile.find(idno)
    if student.id==3 #premade Profile for nonexistent students (check web service)
      flash[:error]="Student not found"
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

    if !verify?(params[:idno], params[:vcode])
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
      

      if f.save
        flash[:notice]="You are now following #{stud.fullname}"
      else
        #Unknown error O.o this should never come up
        flash[:error]="Something went wrong...Try again"
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
