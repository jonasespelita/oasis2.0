class Attendance <  ActiveResource::Base
    self.timeout = 5

  def to_param
    idNo
  end

  def get_status
    #attendanceStatus
    case attendanceStatus
    when "D "
      "Dropped"
    when "WP"
      "Withdrawal with Permission"
    when "TD"
      "Totally Dropped"
    else
      "Not Available."
    end
  end
end
