class ColumnsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:new, :create, :my_project?]
  before_action :my_project?, only: [:new, :create]
  def new
    @column = @project.columns.build
  end

  def create
    @column = @project.columns.build(column_params)
    if @column.save
      redirect_to project_path(@project), notice: (I18n.t 'notice.create_column')
    else
      render :new
    end
  end

  private
  
  def column_params
    params.require(:column).permit(:name)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def my_project?
    unless current_user.id == @project.user_id
      redirect_to myproject_path, notice: (I18n.t 'notice.not_your_project')
    end
  end
end
