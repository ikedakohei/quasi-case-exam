class Column < ApplicationRecord
  belongs_to :project
  validates :name, presence: true, length: { maximum: 40 }
  validates :name, uniqueness: { scope: :project_id }
end
