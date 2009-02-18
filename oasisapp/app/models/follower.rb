class Follower < ActiveRecord::Base
  has_attached_file :photo, :styles => { :small => "90x90"}
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
end
