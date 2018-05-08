class Card < ApplicationRecord
  belongs_to :project
  belongs_to :column

  validates :name, presence: true, length: { maximum: 40 },
                   uniqueness: {scope: [:project_id]}
end
