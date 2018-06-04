class LogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:index]
  before_action :my_project?, only: [:index]

  def index
    @logs = @project.logs.reverse_order.log_pages(params)
  end

  private
  def set_project
    @project = Project.find(params[:project_id])
  end
  # 自分の所属するプロジェクトかどうか判断
  def my_project?
    unless current_user.my_project?(@project)
      redirect_to myproject_path, notice: (I18n.t 'notice.not_your_project')
    end
  end
end
