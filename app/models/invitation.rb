class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :project

  scope :invitation_pages, ->(p) do
    includes(:project).order(created_at: :desc).page(p[:page]).per(5)
  end
end
