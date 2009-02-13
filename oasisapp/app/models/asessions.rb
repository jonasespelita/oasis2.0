class Asessions < ActiveRecord::Base
	belongs_to :admin
	has_many :actions
end
