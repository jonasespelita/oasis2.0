class Notification < ActiveRecord::Base
  def self.smsify text
      fin_text =""
    (text.split(" ")).each do |word|
      fin_text = fin_text +word+"+"
    end
    
    return fin_text
  end
end
 