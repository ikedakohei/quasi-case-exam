class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :project

  def self.notification_pages(params)
    all.includes(:user).order(created_at: :desc).page(params).per(5)
  end
end
