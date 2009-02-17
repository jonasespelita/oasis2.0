class AdminController < ApplicationController
	before_filter :authorize, :except => :login
	def index
		@announcements = Announcements.find(:all)
		@announcements.sort{ |a,b| a.date_time <=> b.date_time}
		@announcements.reverse!
		@admins = Admin.find(:all)
		@admins.sort{ |a,b| a.username <=> b.username}
		@admins.reverse!
		@queries = Query.find(:all)
		@sitesetting = Sitesettings.find_by_id(1)
		if session[:email_id]
			x = TempEmail.find_by_id(session[:email_id])
			@email_content = x.email
		end
		if session[:query_type]
			case session[:query_type]
				when "Main Site Inquiry/Problems":
					@queries = Query.find(:all)
					@queries.delete_if { |x| x.subject.index("Main Site Inquiry/Problems") == nil }
				when "Account Settings Inquiry":
					@queries = Query.find(:all)
					@queries.delete_if { |x| x.subject.index("Account Settings Inquiry") == nil }
				when "Ward Information Inquiry":
					@queries = Query.find(:all)
					@queries.delete_if { |x| x.subject.index("Ward Information Inquiry") == nil }
				when "Ward Addition Inquiry/Problems":
					@queries = Query.find(:all)
					@queries.delete_if { |x| x.subject.index("Ward Addition Inquiry/Problems") == nil }
				when "Miscellaneous":
					@queries = Query.find(:all)
					@queries.delete_if { |x| x.subject.index("Main Site Inquiry/Problems") != nil || x.subject.index("Ward Addition Inquiry/Problems") != nil || x.subject.index("Ward Information Inquiry") != nil || x.subject.index("Account Settings Inquiry") != nil }
				when "All":
					session[:query_type] = nil
					@queries = Query.find(:all)
			end
			if session[:query_from] && session[:query_to]
				@queries.delete_if { |x| x.created_at < Time.parse(session[:query_from]) || x.created_at > Time.parse(session[:query_to]) }
			end
		else	
			@queries = Query.find(:all)
		end
		@queries.sort{ |a,b| a.created_at <=> b.created_at}
		if session[:user_filter]
			case session[:user_filter]
			
				when "blocked":
					@users = User.find(:all)
					@users.delete_if{ |x| x.status != "Blocked" }
				when "student":
					session[:user_filter] = "student"
					@users = User.find(:all)
					@users.delete_if{ |x| numeric?(x.login) == false }
				when "guardian":
					@users = User.find(:all)
					@users.delete_if{ |x| numeric?(x.login) }
				when "last name":
					@users = User.find(:all)
					@users.delete_if{ |x| x.last_name.index(session[:user_filter_last_name]) != 0 }
				when "all":
					session[:user_filter] = nil
					session[:user_filter_last_name] = nil
					@users = User.find(:all)
			end
		else
			@users = User.find(:all)
		end
		#elsif session[:user_filter]
		@users.sort{ |a,b| a.login <=> b.login}
		@users.reverse!
		if session[:change_action]
			case session[:change_action]
				when "Added Announcement":
					@changes = Changes.find(:all)
					@changes.delete_if { |x| x.change_made.index("Added announcement") == nil }
				when "Edited Announcement":
					@changes = Changes.find(:all)
					@changes.delete_if { |x| x.change_made.index("Edited announcement") == nil }
				when "Downloaded Actions Log":
					@changes = Changes.find(:all)
					@changes.delete_if { |x| x.change_made.index("Downloaded Actions Log") == nil }
				when "Downloaded System reports":
					@changes = Changes.find(:all)
					@changes.delete_if { |x| x.change_made.index("Downloaded System Reports") == nil }
				when "Resolved Query":
					@changes = Changes.find(:all)
					@changes.delete_if { |x| x.change_made.index("Resolved query") == nil }
				when "Deleted Query":
					@changes = Changes.find(:all)
					@changes.delete_if { |x| x.change_made.index("Deleted query") == nil }
				when "Removed Student Being Followed":
				
				when "Changed Messaging Settings":
					@changes = Changes.find(:all)
					@changes.delete_if { |x| x.change_made.index("Changed Messaging Settings") == nil }
				when "Put Website Offline":
					@changes = Changes.find(:all)
					@changes.delete_if { |x| x.change_made.index("Put Website Offline") == nil }
				when "Put Website Online":
					@changes = Changes.find(:all)
					@changes.delete_if { |x| x.change_made.index("Put Website Online") == nil }
				when "Edited Email Contents":
				when "Blocked User":
					@changes = Changes.find(:all)
					@changes.delete_if { |x| x.change_made.index("Blocked User") == nil }
				when "Unblocked User":
					@changes = Changes.find(:all)
					@changes.delete_if { |x| x.change_made.index("Unblocked User") == nil }
				when "All":
					session[:change_action] = nil
					@changes = Changes.find(:all)
			end
			if session[:change_from] && session[:change_to]
				@changes.delete_if { |x| x.created_at < Time.parse(session[:change_from]) || x.created_at > Time.parse(session[:change_to]) }
			end
		else	
			@changes = Changes.find(:all)
		end
		@changes.sort{ |a,b| a.created_at <=> b.created_at}
		@cur_ons = CurOnline.find(:all)
		if session[:report_from] && session[:report_to]
				@reports = Report.find(:all)
				@reports.delete_if { |x| x.date < Date.parse(session[:report_from]) || x.date > Date.parse(session[:report_to]) }
		else
			@reports = Report.find(:all)
		end
		@reports.sort{ |a,b| a.date <=> b.date}
		admin = Admin.find(session[:admin_id])
		if admin.position == 'oa'
					@is_oa = true
  		else
					@is_oa = false
		end
	end

  def oa
  	@admins = Admin.find(:all)
  	admin = Admin.find(session[:admin_id])
		if admin.position != 'oa'
			redirect_to(:action => "index")
		end

  end

  def login
  	session[:admin_id] = nil
  	if request.post?
  		admin = Admin.authenticate(params[:name], params[:password])
  		if admin
  			if admin.active == true
			session[:admin_id] = admin.id
			admin.last_visit = Time.now
			admin.save
			session[:cur_on] = CurOnline.new
			session[:cur_on].date = Time.now
			session[:cur_on].name = admin.get_name
			session[:cur_on].position = admin.position
			session[:cur_on].save
			redirect_to(:action => "index")
  			else admin.active == false
  			flash.now[:notice] = "Your account has been disabled"
  			end
  		else
  			flash.now[:notice] = "Invalid user/password combination"
  		end
  	end

  end


  def settings
  	
  	if request.post?
  		flash[:message] = ""
			unless params[:new_password].blank?
				admin = Admin.authenticate(Admin.find(session[:admin_id]).username, params[:current_password])
				if params[:new_password] == params[:confirm_password]
					admin.create_password(params[:new_password])
					admin.save
					flash.now[:message] = flash[:message] + "password changed "
				else
					flash.now[:notice] = "new password did not match"
					flash.now[:message] = nil
				end
			end
			unless params[:new_email].blank?
				admin = Admin.find(session[:admin_id])
				if params[:new_email] == params[:confirm_email]
					admin.email = params[:new_email]
					flash.now[:message] = flash[:message] + "email changed"
				else
					flash.now[:notice] = "new email did not match"
					flash.now[:message] = nil
				end
			end
	end
	
	
		

  end

  def logout
  		session[:cur_on].destroy
  		session[:cur_on] = nil
  		session[:admin_id] = nil
		redirect_to(:action => "login" )
		flash[:message] = "Logged out"
  end

  def edit_activity
  	unless params[:edit_activity_id].blank?
			edited_activity = CampusActivities.find(params[:edit_activity_id])
			edited_activity.date = params[:edit_activity_date]
			edited_activity.activity = params[:edit_activity_name]
			edited_activity.summary = params[:edit_activity_summary]
			unless edited_activity.save
				redirect_to(:action => "index")
				flash[:notice] = "not saved"
			else
				redirect_to(:action => "index")
			end
		else
			redirect_to(:action => "index")
			flash[:notice] = "Please select an activity to be edited"
		end
  end

  def add_activity
  	new_activity = CampusActivities.new
  	new_activity.date = params[:add_activity_date]
  	new_activity.activity = params[:add_activity_name]
  	new_activity.summary = params[:add_activity_summary]
  	unless new_activity.save
  		redirect_to(:action => "index")
  		flash[:notice] = "not saved"
  	end
  	redirect_to(:action => "index")
  end

  	def delete_activity
	  	deleted_activity = CampusActivities.find(params[:delete_activity_id])
	  	unless deleted_activity.destroy
	  		redirect_to(:action => "index")
	  		flash[:notice] = "not deleted"
	  	end
	  	redirect_to(:action => "index")

	end

  def edit_announcement
		unless params[:edit_announcement_id].blank?
			edited_announcement = Announcements.find(params[:edit_announcement_id])
			edited_announcement.date_time = params[:edit_announcement_date]
			edited_announcement.announcement = params[:edit_announcement_name]
			edited_announcement.summary = params[:edit_announcement_summary]
			unless edited_announcement.save
				redirect_to(:action => "index")
				flash.now[:notice] = "not saved"
			else
			act = Changes.new
			act.admin_id = session[:admin_id]
			act.ip_add = request.remote_ip
			act.change_made = "Edited announcement #{params[:edit_announcement_name]}"
			act.save
			flash[:message] = "Announcement sucessfully edited"
			redirect_to(:action => "index")
			end
		else
			redirect_to(:action => "index")
			flash[:notice] = "Please select an announcement to be edited"
		end
  end

  def add_announcement
  	new_announcement = Announcements.new
  	new_announcement.date_time = params[:add_announcement_date]
  	new_announcement.announcement = params[:add_announcement_name]
  	new_announcement.summary = params[:add_announcement_summary]
  	unless new_announcement.save
  		redirect_to(:action => "index")
  		flash[:notice] = "not saved"
  	else
  		act = Changes.new
		act.admin_id = session[:admin_id]
		act.ip_add = request.remote_ip
		act.change_made = "Edited announcement #{params[:add_announcement_name]}"
		act.save
		flash[:message] = "Announcement sucessfully added"
  		redirect_to(:action => "index")
  	end

  end

	def delete_announcement
	  	deleted_announcement = Announcements.find(params[:delete_announcement_id])
	  	unless deleted_announcement.destroy
	  		redirect_to(:action => "index")
	  		flash[:notice] = "not deleted"
	  	else
	  		act = Changes.new
			act.admin_id = session[:admin_id]
			act.ip_add = request.remote_ip
			act.change_made = "Deleted announcement #{params[:delete_announcement_name]}"
			act.save
			redirect_to(:action => "index")
	  	end


	end

	def add_admin
		if params[:add_admin_password] == params[:add_admin_confirm]
			new_admin = Admin.new
			new_admin.first_name = params[:add_admin_first_name].capitalize
			new_admin.last_name = params[:add_admin_last_name].capitalize
			new_admin.position = "General Administrator"
			new_admin.username = params[:add_admin_username]
			new_admin.email = params[:add_admin_email]
			new_admin.active = true
			new_admin.create_password(params[:add_admin_password])
			unless new_admin.save
	  		redirect_to(:action => "index")
	  		flash[:notice] = "not saved"
	  		else
	  		flash[:message] = "Admin successfully added"
	  		redirect_to(:action => "index")
	  		end
	  	else
	  		flash[:notice] = "Add admin passwords do not match"
	  		redirect_to(:action => "index")
	  	end
	end

	def edit_admin
		if params[:edit_admin_password] == params[:edit_admin_confirm]
	  		unless params[:edit_admin_id].blank?
				edit_admin = Admin.find(params[:edit_admin_id])
				edit_admin.first_name = params[:edit_admin_first_name].capitalize
				edit_admin.last_name = params[:edit_admin_last_name].capitalize
				edit_admin.username = params[:edit_admin_username]
				edit_admin.email = params[:edit_admin_email]
				unless params[:edit_admin_password].blank?
					edit_admin.create_password(params[:edit_admin_password])
				end
				unless edit_admin.save
		  		redirect_to(:action => "index")
		  		flash[:notice] = "not saved"
		  		else
		  		flash[:message] = "Admin successfully edited"
		  		redirect_to(:action => "index")
		  		end
	  		else
				redirect_to(:action => "index")
				flash[:notice] = "Please select an admin to be edited"
			end
		else
	  		flash[:notice] = "Edit admin passwords do not match"
	  	end
	  	redirect_to(:action => "index")
	end

	def enable_admin
		unless params[:enable_admin_id].blank?
			enable_admin = Admin.find(params[:enable_admin_id])
			enable_admin.active = true
			unless enable_admin.save
	  		redirect_to(:action => "index")
	  		flash[:notice] = "not saved"
	  		else
	  		flash[:message] = "Admin activated"
	  		redirect_to(:action => "index")
	  		end
	  	else
	  		redirect_to(:action => "index")
			flash[:notice] = "Please select an admin"
		end

	end

	def disable_admin
		unless params[:disable_admin_id].blank?
			disable_admin = Admin.find(params[:disable_admin_id])
			disable_admin.active = false
			unless disable_admin.save
	  		redirect_to(:action => "index")
	  		flash[:notice] = "not saved"
	  		else
	  		flash[:message] = "Admin deactivated"
	  		redirect_to(:action => "index")
	  		end
	  	else
	  		redirect_to(:action => "index")
			flash[:notice] = "Please select an admin"
		end

	end

	def delete_query
		deleted_query = Query.find(params[:delete_user_query_id])
		unless deleted_query.destroy
	  		redirect_to(:action => "index")
	  		flash[:notice] = "not deleted"
	  	else
	  		act = Changes.new
			act.admin_id = session[:admin_id]
			act.ip_add = request.remote_ip
			act.change_made = "Deleted query from #{params[:delete_user_query_sender]} about #{params[:delete_user_query_subject]}"
			act.save
			flash[:message] = "Query deleted"
			redirect_to(:action => "index")
	  	end

	end

	def resolve_query
		resolved_query = Query.find(params[:resolve_user_query_id])
		resolved_query.resolved = true
		resolved_query.resolved_by = session[:admin_id]
		act = Changes.new
		act.admin_id = session[:admin_id]
		act.ip_add = request.remote_ip
		act.change_made = "Resolved query from #{params[:resolve_user_query_sender]} about #{params[:resolve_user_query_subject]}"
		act.save
		resolved_query.save
		flash[:message] = "Query resolved"
		redirect_to(:action => "index")
	end

	def export_actions
		act = Changes.new
		act.admin_id = session[:admin_id]
		act.ip_add = request.remote_ip
		act.change_made = "Downloaded Actions Log"
		act.save
		if session[:change_action]
			case session[:change_action]
				when "Added Announcement":
					@changes = Changes.find(:all)
					@changes.delete_if { |x| x.change_made.index("Added announcement") == nil }
				when "Edited Announcement":
					@changes = Changes.find(:all)
					@changes.delete_if { |x| x.change_made.index("Edited announcement") == nil }
				when "Downloaded Actions Log":
					@changes = Changes.find(:all)
					@changes.delete_if { |x| x.change_made.index("Downloaded Actions Log") == nil }
				when "Downloaded System reports":
					@changes = Changes.find(:all)
					@changes.delete_if { |x| x.change_made.index("Downloaded System Reports") == nil }
				when "Resolved Query":
					@changes = Changes.find(:all)
					@changes.delete_if { |x| x.change_made.index("Resolved query") == nil }
				when "Deleted Query":
					@changes = Changes.find(:all)
					@changes.delete_if { |x| x.change_made.index("Deleted query") == nil }
				when "Removed Student Being Followed":
				when "Put Website Offline":
				when "Put Website Online":
				when "Edited Email Contents":
				when "Blocked User":
					@changes = Changes.find(:all)
					@changes.delete_if { |x| x.change_made.index("Blocked User") == nil }
				when "Unblocked User":
					@changes = Changes.find(:all)
					@changes.delete_if { |x| x.change_made.index("Unblocked User") == nil }
				when "All":
					session[:change_action] = nil
					@changes = Changes.find(:all)
			end
			if session[:change_from] && session[:change_to]
				@changes.delete_if { |x| x.created_at < Time.parse(session[:change_from]) || x.created_at > Time.parse(session[:change_to]) }
			end
		else	
			@changes = Changes.find(:all)
		end
		@changes.sort{ |a,b| a.created_at <=> b.created_at}
		respond_to do |format|
      #format.html
      #format.xml { render :xml => @reports }
      
      format.csv { send_data @changes.to_csv(:except => [:id, :updated_at]) }
     
		#render :layout => false
		#headers['Content-Type'] = "application/vnd.ms-excel"
		#headers['Content-Disposition'] = 'attachment; filename="Actions Log.xls"'
		#headers['Cache-Control'] = ''
      end
       headers['Content-Disposition'] = 'attachment; filename="Actions Log.csv"'
	end

	def export_reports
		act = Changes.new
		act.admin_id = session[:admin_id]
		act.ip_add = request.remote_ip
		act.change_made = "Downloaded System Reports Log"
		act.save
		if session[:report_from] && session[:report_to]
				@reports = Report.find(:all)
				@reports.delete_if { |x| x.date < Date.parse(session[:report_from]) || x.date > Date.parse(session[:report_to]) }
		else
			@reports = Report.find(:all)
		end
		@reports.sort{ |a,b| a.date <=> b.date}
		
 
    
      respond_to do |format|
      #format.html
      #format.xml { render :xml => @reports }
      
      format.csv { send_data @reports.to_csv(:except => [:id, :created_at, :updated_at]) }
    
		#render :layout => false
		#headers['Content-Type'] = "application/vnd.ms-excel"
		#headers['Content-Disposition'] = 'attachment; filename="System Reports.xls"'
		#headers['Cache-Control'] = ''
      end
      headers['Content-Disposition'] = 'attachment; filename="System Reports.csv"'
	end

	def filter_changes
		unless params[:changes_from_date].blank? || params[:changes_to_date].blank?
			unless Time.parse(params[:changes_from_date]) > Time.parse(params[:changes_to_date])
			session[:change_from] = params[:changes_from_date]
			session[:change_to] = params[:changes_to_date]
			session[:change_action] = params[:filter_changes_type]
			redirect_to(:action => "index")
			else
			flash[:notice] = "From date cannot be later than to date"
			redirect_to(:action => "index")
			end
		else
			session[:change_from] = nil
			session[:change_to] = nil
			session[:change_action] = params[:filter_changes_type]
			redirect_to(:action => "index")
		end
	end

	def filter_query
		unless params[:query_from_date].blank? || params[:query_to_date].blank?
			unless Time.parse(params[:query_from_date]) > Time.parse(params[:query_to_date])
			session[:query_from] = params[:query_from_date]
			session[:query_to] = params[:query_to_date]
			redirect_to(:action => "index")
			else
			flash[:notice] = "From date cannot be later than to date"
			redirect_to(:action => "index")
			end
		else
			session[:query_from] = nil
			session[:query_to] = nil
			session[:query_type] = params[:filter_query_type]
			redirect_to(:action => "index")
		end
	end

	def filter_reports
		unless params[:report_from_date].blank? || params[:report_to_date].blank?
			unless Time.parse(params[:report_from_date]) > Time.parse(params[:report_to_date])
			session[:report_from] = params[:report_from_date]
			session[:report_to] = params[:report_to_date]
			redirect_to(:action => "index")
			else
			flash[:notice] = "From date cannot be later than to date"
			redirect_to(:action => "index")
			end
		else
			flash[:notice] = "Please enter dates to filter"
			redirect_to(:action => "index")
		end
	end
	
	def filter_user
		case params[:filter_users_type]
			when "All":
				session[:user_filter] = "all"
			when "Blocked":
				session[:user_filter] = "blocked"
			when "Student":
				session[:user_filter] = "student"
			when "Guardian":
				session[:user_filter] = "guardian"
			when "Last Name":
				session[:user_filter] = "last name"
				session[:user_filter_last_name] = params[:search_user_name]
		end
		redirect_to(:action => "index")
	end
	
	def block_user
		unless params[:block_user_id].blank?
			blocked_user = User.find(params[:block_user_id])
			blocked_user.status = "Blocked"
			unless blocked_user.save
	  		redirect_to(:action => "index")
	  		flash[:notice] = "not saved"
	  		else
	  		act = Changes.new
			act.admin_id = session[:admin_id]
			act.ip_add = request.remote_ip
			act.change_made = "Blocked User #{blocked_user.get_fullname}"
			act.save
	  		flash[:message] = "User Blocked"
	  		redirect_to(:action => "index")
	  		end
	  	else
	  		redirect_to(:action => "index")
			flash[:notice] = "Please select a user"
		end
	end
	def unblock_user
		unless params[:unblock_user_id].blank?
			unblocked_user = User.find(params[:unblock_user_id])
			unblocked_user.status = "Active"
			unless unblocked_user.save
	  		redirect_to(:action => "index")
	  		flash[:notice] = "not saved"
	  		else
	  		act = Changes.new
			act.admin_id = session[:admin_id]
			act.ip_add = request.remote_ip
			act.change_made = "Blocked User #{unblocked_user.get_fullname}"
			act.save
	  		flash[:message] = "User Unblocked"
	  		redirect_to(:action => "index")
	  		end
	  	else
	  		redirect_to(:action => "index")
			flash[:notice] = "Please select a user"
		end
	end
	
	def change_messages_settings
		sitesetting = Sitesettings.find_by_id(1)
		sitesetting.notification_time = DateTime.new(params[:post_notif][:"sunrise(1i)"].to_i, params[:post_notif][:"sunrise(2i)"].to_i, params[:post_notif][:"sunrise(3i)"].to_i, params[:post_notif][:"sunrise(4i)"].to_i, params[:post_notif][:"sunrise(5i)"].to_i, params[:post_notif][:"sunrise(6i)"].to_i)
		sitesetting.notification_monday = if params[:notif_monday] == "yes" then true else false end
		sitesetting.notification_tuesday = if params[:notif_tuesday] == "yes" then true else false end
		sitesetting.notification_wednesday = if params[:notif_wednesday] == "yes" then true else false end
		sitesetting.notification_thursday = if params[:notif_thursday] == "yes" then true else false end
		sitesetting.notification_friday = if params[:notif_friday] == "yes" then true else false end
		sitesetting.notification_saturday = if params[:notif_saturday] == "yes" then true else false end
		sitesetting.notification_sunday = if params[:notif_sunday] == "yes" then true else false end
		sitesetting.email_tme = DateTime.new(params[:post_email][:"sunset(1i)"].to_i, params[:post_email][:"sunset(2i)"].to_i, params[:post_email][:"sunset(3i)"].to_i, params[:post_email][:"sunset(4i)"].to_i, params[:post_email][:"sunset(5i)"].to_i, params[:post_email][:"sunset(6i)"].to_i)
		sitesetting.email_monday = if params[:email_monday] == "yes" then true else false end
		sitesetting.email_tuesday = if params[:email_tuesday] == "yes" then true else false end
		sitesetting.email_wednesday = if params[:email_wednesday] == "yes" then true else false end
		sitesetting.email_thursday = if params[:email_thursday] == "yes" then true else false end
		sitesetting.email_friday = if params[:email_friday] == "yes" then true else false end
		sitesetting.email_saturday = if params[:email_saturday] == "yes" then true else false end
		sitesetting.email_sunday = if params[:email_sunday] == "yes" then true else false end
		DateTime.new(params[:post_sms][:"midnight(1i)"].to_i, params[:post_sms][:"midnight(2i)"].to_i, params[:post_sms][:"midnight(3i)"].to_i, params[:post_sms][:"midnight(4i)"].to_i, params[:post_sms][:"midnight(5i)"].to_i, params[:post_sms][:"midnight(6i)"].to_i)
		sitesetting.sms_monday = if params[:sms_monday] == "yes" then true else false end
		sitesetting.sms_tuesday = if params[:sms_tuesday] == "yes" then true else false end
		sitesetting.sms_wednesday = if params[:sms_wednesday] == "yes" then true else false end
		sitesetting.sms_thursday = if params[:sms_thursday] == "yes" then true else false end
		sitesetting.sms_friday = if params[:sms_friday] == "yes" then true else false end
		sitesetting.sms_saturday = if params[:sms_saturday] == "yes" then true else false end
		sitesetting.sms_sunday = if params[:sms_sunday] == "yes" then true else false end
		sitesetting.save
		act = Changes.new
		act.admin_id = session[:admin_id]
		act.ip_add = request.remote_ip
		act.change_made = "Changed Messaging Settings"
		act.save
		redirect_to(:action => "index") 
	end
	
	def change_site_status
		sitesetting = Sitesettings.find_by_id(1)
		sitesetting.online = if params[:site_status] == "Online" then true else false end
		sitesetting.save
		act = Changes.new
		act.admin_id = session[:admin_id]
		act.ip_add = request.remote_ip
		act.change_made = if sitesetting.online then "Put Website Online" else "Put Website Offline" end
		act.save
		redirect_to(:action => "index") 
	end
	
	def select_email_edit
		case params[:select_email_edit]
		
			when "Checklist":
				email = ""
				File.open(Rails.root+"/app/views/email/checklist.html").each{ |line|
				email = email + line
				}
				a = TempEmail.new
				a.email = email
				a.save
				puts "dito"
				puts "dito"
				puts "dito"
				puts "dito"
				puts "dito"
				puts "dito"
				puts "dito"
				
				puts a.id
				session[:email_id] = a.id
				session[:select_email_edit] = "Checklist"
			when "Dropped":
			when "Grades":
			when "Kicked Out":
			when "Last Chance":
			when "Non-readmittance":
			when "Reduced Load":
			when "Shift":
			when "Totally Dropped":
			when "Transfer":
			when "Tuition Fee Assessment":
			when "Tuition Fee Assessment Update":
			when "Tuition Fee Breakdowns":
			when "Update For Grades":
			when "Violations":
			when "Withdrawn":
		end
		redirect_to(:action => "index") 
	end
	
	def edit_email
		if session[:select_email_edit]
			puts "uu nman"
			puts "uu nman"
			puts "uu nman"
			puts "uu nman"
			puts "uu nman"
			puts "uu nman"
			puts "uu nman"
			puts "uu nman"
			puts "uu nman"
		end
		case session[:select_email_edit]
		
			when "Checklist":
				file = File.new(Rails.root+"/app/views/email/checklist.html", "w+")

				file.puts(params[:edit_email_box])
				file.close
				puts "saved ata e"
			when "Dropped":
			when "Grades":
			when "Kicked Out":
			when "Last Chance":
			when "Non-readmittance":
			when "Reduced Load":
			when "Shift":
			when "Totally Dropped":
			when "Transfer":
			when "Tuition Fee Assessment":
			when "Tuition Fee Assessment Update":
			when "Tuition Fee Breakdowns":
			when "Update For Grades":
			when "Violations":
			when "Withdrawn":
		end
		redirect_to(:action => "index")
	end
	
  private
	def numeric?(object)
		true if Float(object) rescue false
	end




  protected
  	def authorize
  		unless Admin.find_by_id(session[:admin_id])
  			flash[:message] = "Please log in"
  			redirect_to :action => :login
  		end
  	end

end
