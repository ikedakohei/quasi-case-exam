class Column < ApplicationRecord
  has_many :cards, dependent: :destroy
  belongs_to :project
  validates :name, presence: true, length: { maximum: 40 },
                   uniqueness: { scope: :project_id }

  attr_accessor :log_writer

  before_create do
    # orderに初期値を代入
    self.order = self.project.columns.count
  end

  after_destroy do
    # orderの値をリセット
    self.project.columns.order(order: :asc).each_with_index do |column, i|
      column.update_attribute(:order, i)
    end
  end

  after_create  -> { create_log("作成") }
  after_update  -> { create_log("編集") }
  after_destroy -> { create_log("削除") }

  def create_log(action)
    if log_writer
      content = "#{log_writer.name}さんが#{name}カラムを#{action}しました。"
      Log.create!(content: content, image: log_writer.image, project_id: project.id)
    end
  end

  def set_log_writer(user)
    self.log_writer = user
  end

  def order_plus
    self.order + 1
  end

  def order_minus
    self.order - 1
  end

  def move!(params)
    if params == 'right'
      next_column = self.project.columns.find_by(order: self.order_plus)
      self.update_attribute(:order, self.order_plus)
      next_column.update_attribute(:order, next_column.order_minus)
    else
      prev_column = self.project.columns.find_by(order: self.order_minus)
      self.update_attribute(:order, self.order_minus)
      prev_column.update_attribute(:order, prev_column.order_plus)
    end
  end
end
