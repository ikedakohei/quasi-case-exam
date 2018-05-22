class InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project,    only: [:create, :destroy]
  before_action :host_project?,  only: [:create, :destroy]
  before_action :set_invitation, only: [:update, :refuse]

  def create
    if @project.invitations.create(user_id: params[:user_id])
      redirect_to invite_project_path(@project)
    end
  end

  def update
    if @invitation.update_attribute(:accept, true)
      redirect_to notification_path
    end
  end

  def destroy
    if @project.invitations.find_by(user_id: params[:user_id]).destroy
      redirect_to invite_project_path(@project)
    end
  end

  def refuse
    if @invitation.update_attribute(:accept, false)
      redirect_to notification_path
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_invitation
    @invitation = Invitation.find(params[:id])
  end

  def host_project?
    unless current_user.id == @project.user_id
      redirect_to myproject_path, notice: (I18n.t 'notice.not_your_project')
    end
  end
end
