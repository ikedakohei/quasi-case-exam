class Project < ApplicationRecord
  FIRST_PAGE_PER = 8
  DEFAULT_PAGE_PER = 9

  belongs_to :user

  validates :name, presence: true, length: { maximum: 140 }
  validates :content, length: { maximum: 300 }

  def self.page_per(projects)
    projects.first_page? ? projects.per(FIRST_PAGE_PER) : projects.per(DEFAULT_PAGE_PER)
  end
end
