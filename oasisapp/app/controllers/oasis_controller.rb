class OasisController < ApplicationController
  before_filter :login_required
  $followers
  def index
    $user = current_user
    @followers = Follower.find_all_by_user_id($user.id, :order =>"position")
    @profiles = Array.new
    begin
      @last_login = (($user.last_login).localtime).strftime("%a %B %d, %Y %I:%M%p ")
    rescue 
      @last_login = "First Time Login!"
    end

    #for each ward owned, store it in variable @profiles
    @followers.each do |f|
      @profiles<<Profile.find(f.idno)
    end
    @notifications = Notification.find_all_by_follower_id current_user.id
 
    @menu = make_menu
    session[:order] = @followers
    
  end
  def open_sorter
    index
  end
  def sort
    position = Array.new
    flash[:notice] = "sorted!"
     
    params[:wards].each do |ward|
  
      followers = Follower.find_all_by_idno ward
   
      followers.each do |f|
        if f.user_id == current_user.id
          position << f
        end

      end

    end
    flash[:notice] = position.size
    pos = 1
    position.each do |f|
      f.position = pos
      pos=pos+1
      flash[:notice] = "#{flash[:notice]}" + "#{f.position}"
      f.save
    end

    render :nothing => true
  end

  def show_profile
    if verified_followed?
         @schedules = ClassSchedule.find(:all, :from => "/classSchedule/?idno=#{params[:id]}")
      @prof = Profile.find(params[:id])
      @followers=Array.new
      (Follower.find_all_by_idno params[:id]).each do |follower|
        @followers<<User.find(follower.user_id)
    
      end

      render :partial => "profile" ,:locals => { :profile => @prof, :followers =>@followers, :schedules =>@schedules}
    else
   
      
      render :text => "haxor!@"
    end
  end

  def show_attendance
    if verified_followed?
      @prof = Profile.find(params[:id])
      @absences  =  Attendance.find(:all, :from => "/attendance/?idno=#{params[:id]}")
     
      render :partial => "attendance" ,:locals => { :profile => @prof}
    else
    end
  end

  def show_violations
    if verified_followed?
      #@vio = Array.new

      @vio = Violation.find(:all, :from => "/violation/?idno=#{params[:id]}")
      render :partial => "violations"
      #  @viol.each do|v|
      #   if v.idno==params[:id]
      #     @vio << v
  
    else
    end
  end

  def show_grades
    if verified_followed?
      @prof = Profile.find(params[:id])
      @grades = Grade.find(:all, :from => "/grade/?idno=#{params[:id]}")
      @t_units = 0.00
      @p_units = 0.00
      @grades.each do |grade|
        @t_units += 3
        @p_units+= grade.units if !grade.remark
      end
      @p_passed = (@p_units/@t_units * 100).truncate
      @p_units=@p_units.truncate
      @t_units=@t_units.truncate
      a = @grades[0]
      @semester = case a.semester
      when 1
        "First Semester"
      when 2
        "Second Semester"
      else
        "Unknown Semester"
      end
      render :partial => "grade" ,:locals => { :profile => @prof}
    end
  end

  def show_guidance
    @prof = Profile.find(params[:id])
    @guidances = Guidance.find(:all, :from => "/guidance/?idno=#{params[:id]}")
    render :partial => "guidance" ,:locals => { :profile => @prof}
  end

  def show_fees
    @prof = Profile.find(params[:id])
    @payments= PaymentSchedule.find(:all, :from => "/payment_schedule/?idno=#{params[:id]}")
    @tf_breakdown = Tfbreakdown.find(:all, :from => "/tfbreakdown/?idno=#{params[:id]}")
    @tf_assessment = Tfassessment.find(:all, :from => "/tfassessment/?idno=#{params[:id]}")
    render :partial => "payment" ,:locals => { :profile => @prof}
  end
  
  def pref_help
    
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
    menu << "Grades"
    menu << "Guidance"
    menu << "Violations"
    return menu

  end


end
