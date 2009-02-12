class SMS < ActiveRecord::Base
  validates_presence_of     :phone, :smstext
end