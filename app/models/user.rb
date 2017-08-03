class User < ApplicationRecord
  rolify
  resourcify
  has_many :manuals
  acts_as_taggable_on :skills

  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable, :omniauthable,
         :omniauth_providers => [:facebook, :twitter, :vk, :google_oauth2]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.uid = auth.uid
      user.password = Devise.friendly_token[0,20]
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

  def get_name
    name.empty? ? "ID_#{id}" : name
  end
end
