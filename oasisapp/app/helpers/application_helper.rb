# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    def get_follower idno
    followers = Follower.find_all_by_idno idno
    followers.each do |follower|
      if follower.user_id == current_user.id
        return follower
      end
    end
  end
  
    
    
    def coolbox(x,y, title, link, text)
      "<a rel='gb_page_center[#{x}, #{y}]' title='#{title}' href='#{link}'>#{text}</a>"
    end
end
