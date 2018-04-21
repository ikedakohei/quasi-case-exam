class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:edit, :update, :destroy]

  def index
    @projects_page = Project.order("created_at").reverse_order.page(params[:page])
    @projects = @projects_page.first_page? ? @projects_page.per(8) : @projects_page.per(9)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def myproject
    @projects_page = current_user.projects.order("created_at").reverse_order.page(params[:page])
    @projects = @projects_page.first_page? ? @projects_page.per(8) : @projects_page.per(9)

    respond_to do |format|
      format.html
      format.js
    end
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
    @project = current_user.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :content)
  end
end
