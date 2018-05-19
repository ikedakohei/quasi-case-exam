class InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:create, :destroy]

  def create
    if @project.invitations.create(user_id: params[:user_id])
      redirect_to invite_project_path(@project)
    end
  end

  def destroy
    if @project.invitations.find_by(user_id: params[:user_id]).destroy
      redirect_to invite_project_path(@project)
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end
end
