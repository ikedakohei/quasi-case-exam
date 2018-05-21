class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @invited_projects = current_user.invitation_projects.notification_pages(params[:page])
  end
end
