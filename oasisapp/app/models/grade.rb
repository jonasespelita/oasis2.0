class Grade < ActiveResource::Base
   def to_param
    idno
  end
end
