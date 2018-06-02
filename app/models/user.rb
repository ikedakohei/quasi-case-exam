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
    search ? page(page).per(10).where('name ILIKE(?)', "%#{search}%") : page(page).per(10)
  end

  def accept?(project)
    if invitation = invitations.find_by(project_id: project.id)
      invitation.accept
    end
  end

  def my_project?(project)
    id == project.user_id || accept?(project)
  end
end
