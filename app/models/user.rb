class User < ApplicationRecord
  has_many :manuals
  acts_as_taggable_on :skills
  rolify

  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable, :omniauthable,
         :omniauth_providers => [:facebook, :twitter, :vk, :google_oauth2]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.uid = auth.uid
      user.password = Devise.friendly_token[0,20]
      # user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
      user.save
      user.add_role "user"
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.provider_data"] && session["devise.provider_data"]["extra"]["raw_info"]
        user.uid = data["uid"] if user.uid.blank?
      end
    end
  end

  def email_required?
    false
  end

  def will_save_change_to_uid?
    true
  end
end
