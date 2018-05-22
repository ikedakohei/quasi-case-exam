class User < ApplicationRecord
  has_many :invitations, dependent: :destroy
  has_many :invitation_projects, through: :invitations, source: :project

  has_many :projects, dependent: :destroy
  devise :rememberable, :trackable, :omniauthable, omniauth_providers: %i(facebook twitter github)

  validates :name, presence: true

  mount_uploader :image, ImageUploader

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.remote_image_url = auth.info.image
    end
  end

  def self.search(page, search)
    search ? all.page(page).per(10).where('name ILIKE(?)', "%#{search}%") : all.page(page).per(10)
  end

  def invited?(project)
    invitation_projects.exists?(id: project.id)
  end

  def accept?(project)
    invitation = self.invitations.find_by(project_id: project.id)
    invitation.accept
  end

  def my_project?(project)
    self.id == project.user_id || (self.invited?(project) && self.accept?(project))
  end
end
