class Violation < ActiveResource::Base
   def to_param
    idno
  end
end
