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
end
