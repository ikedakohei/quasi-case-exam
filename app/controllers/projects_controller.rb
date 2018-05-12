class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :my_project?, only: [:show, :edit, :update, :destroy]

  # 全プロジェクトを表示
  def index
    @projects_page = Project.all.includes(:user).order(created_at: :desc).page(params[:page])
    # Find page_per method at project.rb
    @projects = Project.page_per(@projects_page)
  end

  # 自分で作成したプロジェクトのみを表示
  def myproject
    @projects_page = current_user.projects.order(created_at: :desc).page(params[:page])
    # Find page_per method at project.rb
    @projects = current_user.projects.page_per(@projects_page)
  end

  def show
    @columns = @project.columns.order(order: :asc)
  end

  def new
    @project = current_user.projects.build
  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      redirect_to myproject_path, notice: (I18n.t 'notice.create_project')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: (I18n.t 'notice.update_project')
    else
      render :edit
    end
  end

  def destroy
    if @project.destroy
      redirect_to myproject_path, notice: (I18n.t 'notice.destroy_project')
    else
      render :edit
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :content)
  end

  # 自分が作成したプロジェクトかどうか判断
  def my_project?
    unless current_user.id == @project.user_id
      redirect_to myproject_path, notice: (I18n.t 'notice.not_your_project')
    end
  end
end
