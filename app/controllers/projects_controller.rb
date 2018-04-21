class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects_page = Project.page(params[:page])
    @projects = @projects_page.first_page? ? @projects_page.per(8) : @projects_page.per(9)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def myproject
    @projects_page = current_user.projects.page(params[:page])
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

  private

  def project_params
    params.require(:project).permit(:name, :content)
  end
end
