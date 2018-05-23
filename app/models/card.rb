class Card < ApplicationRecord
  belongs_to :project
  belongs_to :column

  validates :name, presence: true, length: { maximum: 40 },
                   uniqueness: {scope: [:project_id]}
  
  def move!(params)
    prev_or_next_column = params == 'right' ?
                          project.columns.find_by(order: column.order_plus) :
                          project.columns.find_by(order: column.order_minus)
    update_attribute(:column_id, prev_or_next_column.id)
  end
end
