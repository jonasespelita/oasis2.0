# To change this template, choose Tools | Templates
# and open the template in the editor.


puts "start announcements"
ann_date = '%d.%m.%Y'
File.open(Rails.root+"/CSV/announcement.csv").each {|line|
  temp = line.split(',')  
  ann = Announcement.new
  ann.eventDate = DateTime.strptime(temp[0], ann_date)
  ann.event = temp[1]
  ann.memoDetail = temp[2]
  ann.save
}
puts "end announcements"

puts "start attendance"
File.open(Rails.root+"/CSV/attendance.csv").each {|line|
  temp = line.split(',')
  att = Attendance.new
  att.idNo = temp[1].to_i
  att.code = temp[2].to_i
  att.courseNo = temp[3]
  att.absences = temp[4].to_i
  att.attendanceStatus = temp[5]
  att.asOfDate = Date.parse(temp[6])
  att.save
}
puts "end attendance"

puts "start class schedule"
File.open(Rails.root+"/CSV/class schedule.csv").each {|line|
  temp = line.split(',')
  cs = ClassSchedule.new
  cs.idNo = temp[0].to_i
  cs.code = temp[1].to_i
  cs.courseNo = temp[2]
  cs.descriptiveTitle = temp[3]
  cs.units = temp[4].to_i
  cs.time = temp[5]
  cs.day = temp[6]
  cs.room = temp[7]
  cs.save
}
puts "end class schedule"

puts "start course offerings"
File.open(Rails.root+"/CSV/course offerings.csv").each {|line|
  temp = line.split(',')
  co = CourseOfferings.new
  co.semester = temp[0].to_i
  co.endSchYr = temp[1].to_i
  co.college = temp[2]
  co.code = temp[3].to_i
  co.courseNo = temp[4]
  co.descriptiveTitle = temp[5]
  co.time = temp[6]
  co.day = temp[7]
  co.room = temp[8]
  co.save
}
puts "end course offerings"

puts "start grades"
File.open(Rails.root+"/CSV/grade.csv").each {|line|
  temp = line.split(',')
  g = Grade.new
  g.idNo = temp[2].to_i
  g.semester = temp[0].to_i
  g.endSchYr = temp[1].to_i
  g.courseNo = temp[3]
  g.descriptiveTitle = temp[4]
  g.units = temp[5].to_i
  g.grade = temp[6]
  g.remark = temp[7]
  g.save
}
puts "end grades"

puts "start guidance"
File.open(Rails.root+"/CSV/guidance.csv").each {|line|
  temp = line.split(',')
  g = Guidance.new
  g.idNo = temp[0].to_i
  g.time = temp[1]+"-"+(Time.parse(temp[1])+600).strftime('%H:%M')
  g.day = temp[2]
  g.room = temp[3]
  g.guidanceStatus = temp[4]
  g.save
}
puts "end guidance"

puts "start payment schedule"
File.open(Rails.root+"/CSV/payment schedule.csv").each {|line|
  temp = line.split(',')
  pay = PaymentSchedule.new
  pay.idNo = temp[1].to_i
  pay.dateOfPayment = DateTime.parse(temp[4])
  pay.amt = temp[2].strip.to_f
  pay.textDetail = temp[3]
  pay.save
}
puts "end payment schedule"

puts "start profile"
File.open(Rails.root+"/CSV/profile.csv").each {|line|
  temp = line.split(',')
  profile = Profile.new
  profile.idNo = temp[1].to_i
  profile.familyName = temp[2]
  profile.givenName = temp[3]
  profile.middleName = temp[4]
  profile.gender = temp[5]
  profile.course = temp[6]
  profile.yearLevel = temp[7].to_i
  profile.college = temp[8]
  profile.address = temp[9]
  profile.email = temp[10]
  profile.mobileNumber = "+63"+temp[11]
  profile.fatherName = temp[12]
  profile.motherName = temp[13]
  profile.guardianName = temp[14]
  profile.relationshipToGuardian = temp[15]
  profile.save
}
puts "end profile"

puts "start tuition fee assessment"
File.open(Rails.root+"/CSV/tuition fee assessment.csv").each {|line|
  temp = line.split(',')
  tfa = Tfassessment.new
  tfa.idNo = temp[1].to_i
  tfa.gradingTerm = temp[2]
  tfa.payAmt = temp[3].strip.to_f
  tfa.balanceAsOf = temp[4].strip.to_f
  tfa.save
}
puts "end tuition fee assessment"

puts "start tuition fee breakdown"
File.open(Rails.root+"/CSV/tuition fee breakdown.csv").each {|line|
  temp = line.split(',')
  tfb = Tfbreakdown.new
  tfb.idNo = temp[1].to_i
  tfb.item = temp[2]
  tfb.feeAmt = temp[3].strip.to_f
  tfb.save
}
puts "end tuition fee breakdown"

puts "start violations"
vio_date = '%d.%m.%Y'
File.open(Rails.root+"/CSV/violations.csv").each {|line|
  temp = line.split(',')
  violation = Violation.new
  violation.idNo = temp[0].to_i
  violation.dateOfViolation = DateTime.strptime(temp[1], vio_date)
  violation.offense = temp[2]
  violation.memoDetail = temp[3]
  violation.save
}
puts "end violations"

puts "start mobile number"
mob_date = '%d.%m.%Y'
File.open(Rails.root+"/CSV/mobile number.csv").each {|line|
  temp = line.split(',')
  mobile = MobileNumber.new
  mobile.idNo = temp[0].to_i
  mobile.mobileNumber = temp[1]
  mobile.enrol_date = DateTime.strptime(temp[2],mob_date)
  mobile.save
}
puts "end mobile number"
