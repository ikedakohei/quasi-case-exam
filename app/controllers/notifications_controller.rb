class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @invitations = current_user.invitations.notification_pages(params)
  end
end
