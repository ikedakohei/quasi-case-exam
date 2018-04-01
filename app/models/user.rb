class User < ApplicationRecord
  devise :rememberable, :trackable, :omniauthable, omniauth_providers: %i(facebook twitter github)

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.sns_image = auth.info.image
    end
  end

  mount_uploader :image, ImageUploader

  def image_file
    self.image.present? ? image : sns_image
  end
end
