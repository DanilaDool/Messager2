class FriendshipsController < ApplicationController
  def show
    @users = User.all
    @current_user = current_user
  end
end
