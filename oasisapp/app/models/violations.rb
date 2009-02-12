class Violations < ActiveResource::Base
   def to_param
    idno
  end
end
