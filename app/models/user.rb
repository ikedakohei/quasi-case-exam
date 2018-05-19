class User < ApplicationRecord
  has_many :projects, dependent: :destroy
  devise :rememberable, :trackable, :omniauthable, omniauth_providers: %i(facebook twitter github)

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.remote_image_url = auth.info.image
    end
  end

  def self.search(search)
    if search
      all.where('name ILIKE(?)', "%#{search}%")
    else
      all
    end
  end

  validates :name, presence: true

  mount_uploader :image, ImageUploader
end
