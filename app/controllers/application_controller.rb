class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :store_current_location, :unless => :devise_controller?
  add_breadcrumb "Home", :root_path
  after_action :set_csrf_cookie_for_ng

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

  # protect_from_forgery with: :exception

  private
  # override the devise helper to store the current location so we can
  # redirect to it after loggin in or out. This override makes signing in
  # and signing up work automatically.
  def store_current_location
    store_location_for(:user, request.url)
  end
  # override the devise method for where to go after signing out because theirs
  # always goes to the root path. Because devise uses a session variable and
  # the session is destroyed on log out, we need to use request.referrer
  # root_path is there as a backup
  def after_sign_out_path_for(resource)
    request.referrer || root_path
  end

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  protected

  def verified_request?
    super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
  end
end
