class Follower < ActiveRecord::Base
  has_attached_file :photo, :styles => { :small => "90x90"}
end
