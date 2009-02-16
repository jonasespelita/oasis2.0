class Follower < ActiveRecord::Base
  has_attached_file :photo, :styles => { :small => "120x120"}
end
