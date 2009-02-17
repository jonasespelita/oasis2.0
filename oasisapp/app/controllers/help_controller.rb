class HelpController < ApplicationController
  before_filter :login_required
  layout 'reg'
  def pref_help
    render :text =>"Click on your ward's picture to change it. You can also change the order your wards appear by dragging the text  below each ward."
  end
  
  def attendance_help
    render :text =>" The standards of attendance should be maintained to prevent the giving of school credits to students who do not meet the minimum attendance requirements. The checking of attendance is the responsibility of the faculty. On the other hand it is the responsibility of the student to keep track of his absences so that he knows when his classcard may have been submitted and thus he can claim it before he goes back to his class.

A student who has incurred absences of more than 20% of the required number of class and laboratory periods in a given subject should be given a DROPPED (D) mark."
    
  end
  
  def guidance_help
    
    render :text => "The Guidance Center is a sector of the university that endeavors to help students and other members of the academic community in their decision making and coping. This is realized through its Counseling, Information, Placement and Testing services. Programs designed to further reach out to the students are regularly undertaken: group and individual guidance for those with academic difficulties, lecture-workshops for life enhancement, and management of private scholarships and financial assistance for deserving students. The Psychological Testing Unit handles the psychological assessment and evaluation of students to arrive at a better self-insight. The SLU-Guidance Extension Services assist a number of outlying high schools in their guidance needs."
  end
  
  def show_query
   
  end
  def create_query
     query = Query.new
     query.message = params[:message]
     query.resolved = false
     query.subject = params[:subject]
     query.user_id = current_user.id
     if query.save
     flash[:notice] = "Your query has successfully been sent"  
     redirect_to root_path
     else
       flash[:notice] = "Problems encounteredYour query has not been sent."  
       render :action => "show_query"
     end
     
     
  end
end
