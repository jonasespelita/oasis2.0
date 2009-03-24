module OasisHelper 
 def get_sched_empty?(idNo)
@schedules = ClassSchedule.find(:all, :from => "/classSchedule/?idno=#{idNo}")
@schedules.size==0
 end
end
