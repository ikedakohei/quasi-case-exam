class Project < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 140 }
  validates :content, length: { maximum: 300 }
end
