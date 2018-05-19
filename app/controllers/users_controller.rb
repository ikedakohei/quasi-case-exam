class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_url, notice: (I18n.t 'devise.registrations.updated')
    else
      render 'edit'
    end
  end

  def destroy
    if @user.destroy
      redirect_to root_url, notice: (I18n.t 'devise.registrations.destroyed')
    else
      render 'edit'
    end
  end

  def notification
    @users = User.all
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :image)
  end
end
