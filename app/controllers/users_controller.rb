class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to root_url, notice: (I18n.t 'devise.registrations.updated')
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to root_url, notice: (I18n.t 'devise.registrations.destroyed')
  end

  private

  def user_params
    params.require(:user).permit(:name, :image)
  end
end
