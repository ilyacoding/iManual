class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, alert: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end
  # layout proc {
  #   if request.xhr?
  #     false
  #   else
  #     index
  #     'application' # или другой лейаут
  #   end
  # }

  # def authenticate_user!
  #   unless current_user
  #     if request.xhr?
  #       render json: {msg: "Вы не авторизованы"}, status: 403
  #     else
  #       redirect_to root_path
  #     end
  #   end

  def devise_mapping
    Devise.mappings[:user]
  end

  protect_from_forgery with: :exception
end
