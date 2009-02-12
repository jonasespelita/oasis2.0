class PaymentSchedule < ActiveResource::Base
   def to_param
    idno
  end
end
