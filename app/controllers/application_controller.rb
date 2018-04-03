class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_anonymous_user
  before_action :set_paper_trail_whodunnit
  before_action :update_sanitized_params, if: :devise_controller?
  def update_sanitized_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password,
                                                       :first_name, :last_name, :cell_phone_no, :profession, :avatar])
  end

  def current_anonymous_user
    # @current_anonymous_user ||= AnonymousUser.find(session[:anonymous_user_id]) if session[:anonymous_user_id]
    tmp_user = AnonymousUser.find(session[:anonymous_user_id]) if session[:anonymous_user_id]
    # if tmp_user && tmp_user.oauth_token == session[:anonymous_user_token] && tmp_user.token_expires?
    if tmp_user && tmp_user.oauth_token == session[:anonymous_user_token] && !tmp_user.token_expires?
      @current_anonymous_user ||= tmp_user
    end
  end

  # https://stackoverflow.com/questions/5629480/rails-devise-is-there-a-way-to-ban-a-user-so-they-cant-login-or-reset-their
  # https://github.com/plataformatec/devise/wiki/How-To%3A-Redirect-to-a-specific-page-on-successful-sign-in-and-sign-out
  def after_sign_in_path_for(resource)
    if resource.banned?
      sign_out resource
      flash[:error] = "This account has been suspended for violation"
      flash[:notice] = ''
      site_home_path
    else
      site_main_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    main_app.root_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    # TODO -- create report that is telling that this user trying to violate the site constraint
    redirect_to main_app.root_path
  end

end
