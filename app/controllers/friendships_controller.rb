class FriendshipsController < ApplicationController
  before_action :authenticate_user!
    def show
      @users = User.all
      @current_user = current_user
    end
    def create
      @friendship = Friendship.new(requester_id: current_user.id, requested_id: params[:requested_id], status: 'pending')

      if @friendship.save
        flash[:notice] = 'Запрос на дружбу отправлен'
      else
        flash[:alert] = 'Не удалось отправить запрос на дружбу'
      end

      redirect_back fallback_location: root_path
    end

    def accept
      @friendship = Friendship.find_by(id: params[:id], requested_id: current_user.id)

      if @friendship
        @friendship.update(status: 'accepted')
        flash[:notice] = 'Запрос на дружбу принят'
      else
        flash[:alert] = 'Невозможно принять запрос на дружбу'
      end

      redirect_back fallback_location: root_path
    end

    def reject
      @friendship = Friendship.find_by(id: params[:id], requested_id: current_user.id)

      if @friendship
        @friendship.update(status: 'rejected')
        flash[:notice] = 'Запрос на дружбу отклонен'
      else
        flash[:alert] = 'Невозможно отклонить запрос на дружбу'
      end

      redirect_back fallback_location: root_path
    end
  end

