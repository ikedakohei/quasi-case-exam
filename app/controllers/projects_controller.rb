class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project,   only: [:show, :edit, :update, :destroy, :invite]
  before_action :my_project?,   only: [:show]
  before_action :host_project?, only: [:edit, :update, :destroy, :invite]

  # 全プロジェクトを表示
  def index
    @projects = Project.page_per(params)
  end

  # 自分で作成したプロジェクトのみを表示
  def myproject
    @projects = Project.myprojects(current_user).page_per(params)
  end

  def show
    @columns = @project.columns.all.includes(:cards).order(order: :asc).decorate
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

  def invite
    # @usersにcurrent_user以外のユーザを代入
    @users = User.search(params[:page], params[:search]).where.not(id: current_user.id)
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :content)
  end

  # 自分の所属するプロジェクトかどうか判断
  def my_project?
    unless current_user.my_project?(@project)
      redirect_to myproject_path, notice: (I18n.t 'notice.not_your_project')
    end
  end

  # 自分で作成したプロジェクトかどうか判断
  def host_project?
    unless current_user.id == @project.user_id
      redirect_to myproject_path, notice: (I18n.t 'notice.not_your_project')
    end
  end
end
