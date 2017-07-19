class User < ApplicationRecord
  rolify
  has_many :manuals
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :recoverable
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
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
  #
  # def self.new_with_session(params, session)
  #   super.tap do |user|
  #     if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
  #       user.email = data["email"] if user.email.blank?
  #     end
  #   end
  # end
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.provider_data"] && session["devise.provider_data"]["extra"]["raw_info"]
        user.uid = data["uid"] if user.uid.blank?
        # user.email = data["email"] if user.email.blank?
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
