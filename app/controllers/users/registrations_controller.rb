class Users::RegistrationsController < Devise::RegistrationsController

  def new
    # puts "HELLO WORLDD!!! CUSTOM DEVISE Action=New"
    # puts "---------- What we got from session -----------"
    # puts session[:anonymous_user_id]
    # puts session[:anonymous_user_token]
    if current_anonymous_user && /@ait.((asia)|(ac.th))/.match(@current_anonymous_user.email)
      flash[:notice] = "Google+ AIT account Verified!"
      super
    else
      flash[:error] = "Please use Google+ AIT account to verify for Sign Up"
      redirect_to root_path
    end
  end

  def show
    @user=User.find(params[:id])

  end

  def create
    # Hack for now --> need to fully override devise create
    # if current_anonymous_user
    #   AnonymousUser.find_by_id(@current_anonymous_user.id).destroy
    #   session[:anonymous_user_id] = nil
    #   session[:anonymous_user_token] = nil
    # end
    # super

    if current_anonymous_user

      build_resource(sign_up_params)

      resource.save
      yield resource if block_given?
      if resource.persisted?
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
          # @current_anonymous_user.destroy unless @current_anonymous_user.nil?
          # session[:anonymous_user_id] = nil
          # session[:anonymous_user_token] = nil
          destroy_session
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end

    else
      # Session Error
      flash[:error] = "Registration Session Expired"
      destroy_session
      redirect_to root_path
    end
  end


  # https://github.com/plataformatec/devise/wiki/How-To:-Redirect-to-a-specific-page-on-successful-sign-up-(registration)
  def after_sign_up_path_for(resource)
    site_main_path # Or :prefix_to_your_route
  end

  private
  def destroy_session
    tmp_user = AnonymousUser.find(session[:anonymous_user_id]) if session[:anonymous_user_id]
    tmp_user.destroy if tmp_user
    session[:anonymous_user_id] = nil
    session[:anonymous_user_token] = nil
  end
end
