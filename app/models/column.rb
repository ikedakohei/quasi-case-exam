class Column < ApplicationRecord
  has_many :cards, dependent: :destroy
  belongs_to :project
  validates :name, presence: true, length: { maximum: 40 },
                   uniqueness: { scope: :project_id }

  before_create do
    # orderに初期値を代入
    order = project.columns.count
  end

  after_destroy do
    # orderの値をリセット
    project.columns.order(order: :asc).each_with_index do |column, i|
      column.update_attribute(:order, i)
    end
  end

  def order_plus
    order + 1
  end

  def order_minus
    order - 1
  end

  def move!(params)
    if params == 'right'
      next_column = project.columns.find_by(order: order_plus)
      update_attribute(:order, order_plus)
      next_column.update_attribute(:order, next_column.order_minus)
    else
      prev_column = project.columns.find_by(order: order_minus)
      update_attribute(:order, order_minus)
      prev_column.update_attribute(:order, prev_column.order_plus)
    end
  end
end
