class Column < ApplicationRecord
  has_many :cards, dependent: :destroy
  belongs_to :project
  validates :name, presence: true, length: { maximum: 40 }
  validates :name, uniqueness: { scope: :project_id }

  before_create do
    # orderに初期値を代入
    self.order = self.project.columns.count
  end

  def order_plus
    self.order += 1
  end

  def order_minus
    self.order -= 1
  end
end
