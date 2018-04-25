class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy, :my_project?]
  before_action :my_project?, only: [:edit, :update, :destroy]

  # 全プロジェクトを表示
  def index
    set_projects(Project)
  end

  def show
  end

  # 自分で作成したプロジェクトのみを表示
  def myproject
    set_projects(current_user.projects)
  end

  def new
    @project = current_user.projects.build
  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      redirect_to myproject_path, notice: I18n.t('notice.create_project')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to myproject_path, notice: I18n.t('notice.update_project')
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

  def set_projects(projects)
    @projects_page = projects.order("created_at").reverse_order.page(params[:page])
    # Find page_per method at project.rb
    @projects = projects.page_per(@projects_page)
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
