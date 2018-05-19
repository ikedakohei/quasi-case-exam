class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = current_user.notification_pages(params[:page])
  end
end
