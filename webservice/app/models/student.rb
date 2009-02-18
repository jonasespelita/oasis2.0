class Student < ActiveRecord::Base
    def to_param
    idno
  end
end
