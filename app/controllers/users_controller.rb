class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = I18n.t 'devise.registrations.updated'
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:notice] = I18n.t 'devise.registrations.destroyed'
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :image)
  end
end
