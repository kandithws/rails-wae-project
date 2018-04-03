class AnonymousSessionsController < ApplicationController
  def create
    user = AnonymousUser.from_omniauth(request.env["omniauth.auth"])
    session[:anonymous_user_id] = user.id
    session[:anonymous_user_token] = user.oauth_token
    redirect_to new_user_registration_path
  end
end
