module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      process_auth("facebook")
    end

    def vk
      process_auth("vk")
    end

    def twitter
      process_auth("twitter")
    end

    def google_oauth2
      process_auth("google")
    end

    def failure
      redirect_to(root_path)
    end

    private

    def process_auth(provider)
      if (user = User.from_omniauth(request.env["omniauth.auth"])).persisted?
        sign_in_and_redirect(user, event: :authentication)
        set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
      else
        session["devise.#{provider}_data"] = request.env["omniauth.auth"].except("extra")
        redirect_to(new_user_registration_url)
      end
    end
  end
end
