class User < ApplicationRecord
  include Gravtastic
  resourcify
  rolify
  ratyrate_rater
  gravtastic

  has_many :manuals, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :completed_steps, dependent: :destroy

  devise :database_authenticatable, :registerable, :rememberable, :trackable, :omniauthable,
         omniauth_providers: %i(facebook twitter vk google_oauth2)

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
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

  def global_name
    name.empty? ? "ID_#{id}" : name
  end
end
