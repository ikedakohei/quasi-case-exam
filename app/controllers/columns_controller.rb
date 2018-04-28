class ColumnsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:new, :create, :edit, :update, :destroy, :my_project?]
  before_action :my_project?, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_column,  only: [:edit, :update, :destroy]
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

  def edit
  end

  def update
    if @column.update(column_params)
      redirect_to project_path(@project), notice: (I18n.t 'notice.update_column')
    else
      render :edit
    end
  end

  def destroy
    if @column.destroy
      redirect_to project_path(@project), notice: (I18n.t 'notice.destroy_column')
    else
      render :edit
    end
  end

  private
  
  def column_params
    params.require(:column).permit(:name)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_column
    @column = @project.columns.find(params[:id])
  end

  def my_project?
    unless current_user.id == @project.user_id
      redirect_to myproject_path, notice: (I18n.t 'notice.not_your_project')
    end
  end
end
