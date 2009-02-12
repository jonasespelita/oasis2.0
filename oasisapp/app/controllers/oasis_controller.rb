class OasisController < ApplicationController
  before_filter :login_required
  
  def index
    $user = current_user
    followers = Follower.find_all_by_user_id($user.id)
    @profiles = Array.new
    begin
      @last_login = (($user.last_login).localtime).strftime("%a %B %d, %Y %I:%M%p ")
    rescue 
      @last_login = "First Time Login!"
    end

    #for each ward owned, store it in variable @profiles
    followers.each do |f|
      @profiles<<Profile.find(f.idno)
          
    end
    
    @menu = make_menu
 
  end

  def show_profile
    if verified_followed?
      @prof = Profile.find(params[:id])
      @followers=Array.new
       (Follower.find_all_by_idno params[:id]).each do |follower|
         @followers<<User.find(follower.user_id)
       end

      render :partial => "profile" ,:locals => { :profile => @prof, :followers =>@followers}
    else
   
      
      render :text => "haxor!@"
    end
  end

  def show_attendance
    if verified_followed?
      @prof = Profile.find(params[:id])
      @absences  =  Attendance.find(:all, :from => "/attendance/?id=#{params[:id]}.xml")
     
      render :partial => "attendance" ,:locals => { :profile => @prof}
    else
    end
  end

  def show_violations
    if verified_followed?
      #@vio = Array.new

      @vio = Violation.find(:all, :from => "/violation/?id=#{params[:id]}.xml")
      render :partial => "violations"
      #  @viol.each do|v|
      #   if v.idno==params[:id]
      #     @vio << v
          
      
     
        
    else
    end
  end
  
  protected
  def verified_followed?
    followers = Follower.find_all_by_user_id(current_user.id)
    followers.each do |follower|
      return true if follower.idno.to_s == params[:id].to_s
    end
    return false
  end

  def make_menu
    menu = Array.new
    menu << "Profile"
    menu << "Attendance"
    menu << "Fees"
    menu << "Course Offerings"
    menu << "Grades"
    menu << "Guidance"
    menu << "Violations"
    return menu

  end


end
