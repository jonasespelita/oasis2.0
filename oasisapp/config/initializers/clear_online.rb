begin
if CurOnline.find(:all)
	a = CurOnline.find(:all)
	a.each { |a| a.destroy }
end	
if TempEmail.find(:all)
	a = TempEmail.find(:all)
	a.each { |a| a.destroy }
end	
rescue
end
