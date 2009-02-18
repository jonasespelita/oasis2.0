require 'digest/sha1'
class User < ActiveRecord::Base
  
  # Virtual attribute for the unencrypted password
  attr_accessor :password

  validates_acceptance_of :terms_of_service
  validates_presence_of     :login, :email, :first_name, :last_name, :nickname, :address, :cp_number
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 6..32, :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  validates_length_of       :login,    :within => 6..32
  validates_length_of       :nickname, :within => 1..10
  validates_length_of       :email,    :within => 3..100
  validates_length_of       :nickname,    :within => 2..10
  validates_uniqueness_of   :login, :email, :case_sensitive => false

  validates_format_of         :email, :with => /(.+)@(.+)\.(.{3})/
  validates_format_of        :login, :with => /\A[A-Za-z_0-9]+\Z/
  validates_format_of        :first_name, :with => /\A[A-Za-z\s]+\Z/
  validates_format_of        :middle_name, :with => /(\A[A-Za-z\s]+\Z)*/
  validates_format_of        :last_name, :with => /\A[A-Za-z\s]+\Z/
  validates_format_of        :nickname, :with => /\A[A-Za-z]+\Z/
  validates_format_of        :cp_number, :with =>   /\A([\+]?(63[0-9]{10}\Z)|(0[0-9]{10})*\Z)/
  before_save :encrypt_password, :set_defaults
  
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :password, :password_confirmation, :first_name, :last_name, :nickname, :address, :terms_of_service, :middle_name, :cp_number, :lang_pref

  def get_fullname
    "#{first_name} #{middle_name} #{last_name}"
  end
  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password)
    u = find_by_login(login) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at 
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    remember_me_for 2.weeks
  end

  def remember_me_for(time)
    remember_me_until time.from_now.utc
  end

  def remember_me_until(time)
    self.remember_token_expires_at = time
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  protected
  # before filter
  def set_defaults
    if !self.lang_pref
      self.lang_pref = 1
    end
   
  end
  def encrypt_password
    return if password.blank?
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
    self.crypted_password = encrypt(password)
  end
      
  def password_required?
    crypted_password.blank? || !password.blank?
  end
    
    
end
