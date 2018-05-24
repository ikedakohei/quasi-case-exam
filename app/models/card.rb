class Card < ApplicationRecord
  belongs_to :project
  belongs_to :column

  validates :name, presence: true, length: { maximum: 40 },
                   uniqueness: {scope: [:project_id]}
  
  def move!(params)
    prev_or_next_column = params == 'right' ?
                          self.project.columns.find_by(order: self.column.order_plus) :
                          self.project.columns.find_by(order: self.column.order_minus)
    self.update_attribute(:column_id, prev_or_next_column.id)
  end
end
