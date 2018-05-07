class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:new, :create, :edit, :update, :destroy]
  before_action :my_project?, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_column,  only: [:new, :create, :edit, :update, :destroy]
  before_action :set_card,    only: [:edit, :update, :destroy]

  def new
    @card = @column.cards.build
  end

  def create
    @card = @column.cards.build(card_params)
    if @card.save
      redirect_to project_path(@project), notice: (I18n.t 'notice.create_card')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @card.update(card_params)
      redirect_to project_path(@project), notice: (I18n.t 'notice.update_card')
    else
      render :edit
    end
  end

  def destroy
    if @card.destroy
      redirect_to project_path(@project), notice: (I18n.t 'notice.destroy_card')
    else
      render :edit
    end
  end

  private

  def card_params
    params.require(:card).permit(:name, :deadline, :assignee_id, :column_id, :project_id)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_column
    @column = @project.columns.find(params[:column_id])
  end

  def set_card
    @card = @column.cards.find(params[:id])
  end

  def my_project?
    unless current_user.id == @project.user_id
      redirect_to myproject_path, notice: (I18n.t 'notice.not_your_project')
    end
  end
end
