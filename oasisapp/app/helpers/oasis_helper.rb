module OasisHelper
  def get_follower idno
    followers = Follower.find_all_by_idno idno
    followers.each do |follower|
      if follower.user_id == current_user.id
        return follower
      end
    end
  end
end
