class Query < ActiveRecord::Base
	belongs_to :users
        
   validates_presence_of     :message, :subject
end
