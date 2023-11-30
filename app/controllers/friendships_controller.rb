class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def show
    @users = User.where.not(id: current_user.id)
    @current_user = current_user
  end

  def index
    @users = User.where.not(id: current_user.id)
    @current_user = current_user
  end

  def create
    requested_user = User.find(params[:friendship][:requested_id])

    if current_user.friends.include?(requested_user)
      flash[:alert] = 'Этот пользователь уже ваш друг'
      redirect_back fallback_location: root_path
    elsif current_user.pending_friend_requests.exists?(requested_id: requested_user.id)
      flash[:alert] = 'Запрос на дружбу уже был отправлен'
      redirect_back fallback_location: root_path
    else
      @friendship = Friendship.new(requester_id: current_user.id, requested_id: requested_user.id, status: 'pending', sent_request: true)

      if @friendship.save
        flash[:notice] = 'Запрос на дружбу отправлен'
      else
        flash[:alert] = 'Не удалось отправить запрос на дружбу'
      end

      redirect_back fallback_location: root_path
    end
  end

  def accept
    @friendship = Friendship.find_by(id: params[:id], requested_id: current_user.id, status: 'pending')

    if @friendship
      if @friendship.status == 'pending'
        Friendship.transaction do
          @friendship.update(status: 'accepted')

          # Отменяем все остальные запросы от этого пользователя,
          # которые имеют статус 'pending'
          Friendship.where(requester_id: @friendship.requester_id, requested_id: @friendship.requested_id, status: 'pending')
                    .where.not(id: @friendship.id)
                    .update_all(status: 'rejected')

          reverse_friendship = Friendship.create(requester_id: @friendship.requested_id, requested_id: @friendship.requester_id, status: 'accepted')
          flash[:notice] = 'Запрос на дружбу принят'
        end
      else
        flash[:alert] = 'Запрос на дружбу уже принят'
      end
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
