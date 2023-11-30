class FriendsController < ApplicationController
  def show
    @friend_requests = Friendship.pending_requests_for(current_user)
  end

  def index

  end

end
