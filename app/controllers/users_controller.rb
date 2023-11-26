class UsersController < ApplicationController
  
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to edit_user_path(@user), notice: 'Профиль успешно обновлен.'
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :descriptions, :avatar)
  end
end
