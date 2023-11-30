class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def show
    @users = User.where.not(id: current_user.id)
    @current_user = current_user
  end

  def create
    requested_user = User.find(params[:friendship][:requested_id])

    if current_user.friends.include?(requested_user)
      flash[:alert] = 'Этот пользователь уже ваш друг'
      redirect_back fallback_location: root_path
    elsif current_user.requested_friendships.exists?(requested_id: requested_user.id, status: 'rejected')
      @friendship = Friendship.new(requester_id: current_user.id, requested_id: requested_user.id, status: 'pending')

      if @friendship.save
        flash[:notice] = 'Запрос на дружбу отправлен'
      else
        flash[:alert] = 'Не удалось отправить запрос на дружбу'
      end

      redirect_back fallback_location: root_path
    elsif current_user.pending_friend_requests.exists?(requested_id: requested_user.id)
      flash[:alert] = 'Запрос на дружбу уже был отправлен'
      redirect_back fallback_location: root_path
    else
      flash[:alert] = 'Невозможно отправить запрос на дружбу'
      redirect_back fallback_location: root_path
    end
  end

  def accept
    @friendship = Friendship.find_by(id: params[:id], requested_id: current_user.id)

    if @friendship && @friendship.status == 'pending'
      Friendship.transaction do
        @friendship.update(status: 'accepted')

        reverse_friendship = Friendship.create(requester_id: @friendship.requested_id, requested_id: @friendship.requester_id, status: 'accepted')
      end

      flash[:notice] = 'Запрос на дружбу принят'
    else
      flash[:alert] = 'Невозможно принять запрос на дружбу'
    end

    redirect_back fallback_location: root_path
  end


  def reject
    @friendship = Friendship.find_by(id: params[:id], requested_id: current_user.id)

    if @friendship && @friendship.status == 'pending'
      @friendship.update(status: 'rejected')
      flash[:notice] = 'Запрос на дружбу отклонен'
    else
      flash[:alert] = 'Невозможно отклонить запрос на дружбу'
    end

    redirect_back fallback_location: root_path
  end

end
