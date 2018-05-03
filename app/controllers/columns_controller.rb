class ColumnsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:new, :create, :edit, :update, :destroy, :right, :left]
  before_action :my_project?, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_column,  only: [:edit, :update, :destroy]
  def new
    @column = @project.columns.build
  end

  def create
    @column = @project.columns.build(column_params)
    @column.order = @project.columns.count
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
      # orderカラムの値をリセット
      @project.columns.order(order: :asc).each_with_index do |column, i|
        unless column.update_attribute(:order, i)
          render :edit
        end
      end

      redirect_to project_path(@project), notice: (I18n.t 'notice.destroy_column')
    else
      render :edit
    end
  end

  # カラムを右へ移動
  def right
    column = @project.columns.find(params[:column_id])
    column_next = @project.columns.find_by(order: column.order + 1)
    order_plus = column.order + 1
    order_minus = column_next.order - 1
    if column.update_attribute(:order, order_plus) && column_next.update_attribute(:order, order_minus)
      redirect_to project_path(@project)
    else
      render project_path(@project)
    end
  end

  # カラムを左へ移動
  def left
    column = @project.columns.find(params[:column_id])
    column_prev = @project.columns.find_by(order: column.order - 1)
    order_minus = column.order - 1
    order_plus = column_prev.order + 1
    if column.update_attribute(:order, order_minus) && column_prev.update_attribute(:order, order_plus)
      redirect_to project_path(@project)
    else
      render project_path(@project)
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
