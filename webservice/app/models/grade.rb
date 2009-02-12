class Grade < ActiveRecord::Base
   def to_param
    idNo
  end
end
