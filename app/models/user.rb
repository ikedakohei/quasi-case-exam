class User < ApplicationRecord
  devise :rememberable, :trackable, :omniauthable, omniauth_providers: %i(facebook twitter github)

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.image = auth.info.image
    end
  end
end
