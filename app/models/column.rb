class Column < ApplicationRecord
  has_many :cards, dependent: :destroy
  belongs_to :project
  validates :name, presence: true, length: { maximum: 40 },
                   uniqueness: { scope: :project_id }

  before_create do
    # orderに初期値を代入
    self.order = self.project.columns.count
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
