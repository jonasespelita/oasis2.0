class Profile < ActiveResource::Base

  self.timeout = 5

  def to_param
    idNo
  end

  def fullname
    "#{givenName} #{middleName} #{familyName}"
  end

  def yrcourse
    "#{course} #{yearLevel}"
  end
end
