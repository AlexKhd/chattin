class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale
  before_filter :update_sanitized_params, if: :devise_controller?

  def set_locale
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    I18n.locale = extract_locale_from_accept_language_header
    logger.debug "* Locale set to '#{I18n.locale}'"
  end

  alias_method :devise_current_user, :current_user

  def current_user
    if params[:user_id].blank?
      devise_current_user
    else
      User.find(params[:user_id])
    end
  end

  private

  def extract_locale_from_accept_language_header
    http_accept_language = request.env['HTTP_ACCEPT_LANGUAGE']
    http_accept_language ? http_accept_language.scan(/^[a-z]{2}/).first : :en
  end

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:name, :email, :password, :password_confirmation)}
  end

end
