class Log < ApplicationRecord
  belongs_to :projects, optional: true

  scope :log_pages, ->(p) do
    order(created_at: :desc).page(p[:page]).per(5)
  end
end
