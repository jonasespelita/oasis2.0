if CurOnline.find(:all)
	a = CurOnline.find(:all)
	a.each { |a| a.destroy }
end	
