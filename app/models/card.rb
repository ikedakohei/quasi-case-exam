class Card < ApplicationRecord
  belongs_to :project
  belongs_to :column

  validates :name, presence: true, length: { maximum: 40 },
                   uniqueness: {scope: [:project_id]}

  attr_accessor :log_writer

  after_save do
    assignee_changed_log if log_writer && saved_change_to_assignee_id?
  end

  after_create -> { create_log("作成") }

  after_update do
    if log_writer && saved_change_to_column_id?
      moved_log if log_writer && saved_change_to_column_id?
    else
      create_log("編集")
    end
  end

  after_destroy -> { create_log("削除") }

  def create_log(action)
    if log_writer
      content = "#{log_writer.name}さんが#{name}カードを#{action}しました。"
      Log.create!(content: content, image: log_writer.image, project_id: project.id)
    end
  end

  def set_log_writer(user)
    self.log_writer = user
  end

  def assignee_user_name
    User.find(self.assignee_id).name
  end

  def assignee_changed_log
    content = "#{log_writer.name}さんが#{name}カードを#{assignee_user_name}さんにアサインしました。"
    Log.create!(content: content, image: log_writer.image, project_id: project.id)
  end

  def moved_log
    content = "#{log_writer.name}さんが#{name}カードを#{column.name}カラムに移動しました。"
    Log.create!(content: content, image: log_writer.image, project_id: project.id)
  end

  def move!(params)
    prev_or_next_column = params == 'right' ?
                          self.project.columns.find_by(order: self.column.order_plus) :
                          self.project.columns.find_by(order: self.column.order_minus)
    self.update_attribute(:column_id, prev_or_next_column.id)
  end

  def self.deadline_log
    assignee_user = User.find(self.assignee_id)
    cards = Card.where('deadline <= ?', Date.today)
    cards.each do |card|
      content = card.deadline.today? ? "#{assignee_user.name}さん、本日が#{name}カードの締切期限です。"
                                     : "#{assignee_user.name}さん、#{name}カードの締切期限が過ぎています。"
      Log.create!(content: content, image: assignee_user.image, project_id: project.id)
    end
  end
end
