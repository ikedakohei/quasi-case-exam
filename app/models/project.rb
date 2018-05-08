class Project < ApplicationRecord
  FIRST_PAGE_PER = 8
  DEFAULT_PAGE_PER = 9

  belongs_to :user
  has_many :columns, dependent: :destroy
  has_many :cards, dependent: :destroy

  validates :name, presence: true, length: { maximum: 140 }
  validates :content, length: { maximum: 300 }

  def self.page_per(projects)
    projects.first_page? ? projects.per(FIRST_PAGE_PER) : projects.per(DEFAULT_PAGE_PER)
  end

  def reset_column_order
    self.columns.order(order: :asc).each_with_index do |column, i|
      unless column.update_attribute(:order, i)
        render "columns#edit"
      end
    end
  end
end
