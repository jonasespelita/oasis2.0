class UserMailer < ActionMailer::Base
  def sendmail
    recipients "ay.buenavista@gmail.com,noreendaniellefabia@hotmail.com,noreendanielle@gmail.com"
    from         "woopie"
    subject     "rawrawr"
    body        "testing mail"
  end

end
