class Admin < ActiveRecord::Base
	has_many :changes
	
  validates_presence_of     :username
  validates_uniqueness_of   :username
 
  attr_accessor :password_confirmation
  validates_confirmation_of :password

  validate :password_non_blank
  

  
		def self.authenticate(username, password)
		  admin = self.find_by_username(username)
		  if admin
		    expected_password = encrypted_password(password, admin.salt)
		    if admin.hashed_password != expected_password
		      admin = nil
		    end
		  end
		  admin
		end
		
		
		# 'password' is a virtual attribute
		
		def password
		  @password
		end
		
		def get_name
			"#{self.first_name} #{self.last_name}"
		end
		
		def create_password(pwd)
		  @password = pwd
		  return if pwd.blank?
		  create_new_salt
		  self.hashed_password = Admin.encrypted_password(self.password, self.salt)
		end
		
		def after_destroy
			if Admin.count.zero?
				raise "Can't delete last admin"
			end
		end
		
		

	private

		def password_non_blank
		  errors.add(:password, "Missing password") if hashed_password.blank?
		end

		
		
		def create_new_salt
		  self.salt = self.object_id.to_s + rand.to_s
		end
		
		
		
		def self.encrypted_password(password, salt)
		  string_to_hash = password + "wibble" + salt
		  Digest::SHA1.hexdigest(string_to_hash)
		end
end
