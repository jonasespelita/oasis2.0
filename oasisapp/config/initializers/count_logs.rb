begin
	a = (Time.now-1).strftime("%m/%d/%Y").to_s
	puts a
	
	b = UserLogs.find_all_by_created_at(a)
	puts b
	b.each{ |c| c.created_at = Time.now-1}
	
	unless Report.find_by_date(a)
		d = Report.new
		d.total = b.length
		d.date = a
		d.unique = b.uniq.length
		d.save
	end
rescue
end
	
