class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  # def vk
  # end
  #
  # def twitter
  # end
  #
  # def google
  # end


  def after_sign_in_path_for(resource)
    super resource
    # if resource.email_verified?
    #   super resource
    # else
    #   finish_signup_path(resource)
    # end
  end

  def failure
    redirect_to root_path
  end
end
