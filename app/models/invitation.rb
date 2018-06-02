class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :project

  scope :notification_pages, ->(p) do
    includes(:project).order(created_at: :desc).page(p[:page]).per(5)
  end

  scope :log_pages, ->(p) do
    order(created_at: :desc).page(p[:page]).per(5)
  end
end
