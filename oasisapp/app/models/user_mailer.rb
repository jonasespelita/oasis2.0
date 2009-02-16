class UserMailer < ActionMailer::Base
  def sendmail
    recipients "ay.buenavista@gmail.com,noreendaniellefabia@hotmail.com,noreendanielle@gmail.com"
    from         "woopie"
    subject     "rawrawr"
    body        "testing mail"
  end

  def forgot_password_mail username, password
    u = User.find_by_login(username)
    
     recipients  u.email
     subject "No-Reply"
     u.password=password
     u.password_confirmation = password
     body "your new password is #{password}"
     u.save
  end
end
