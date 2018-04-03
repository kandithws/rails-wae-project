class UserinfoController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_from_id, only: [:postuser, :update_profile]

  def postuser
    @items = @user.items
    @bid_count=1
  end

  def edit_profile
    @user = current_user
    @posts = @user.items
  end

  def update_profile
    if @user.id == current_user.id
      respond_to do |format|
        if @user.update(user_params)
          format.html {redirect_to profile_path, notice: 'User was successfully updated.'}
          format.json {render :profile, status: :ok, location: @user}
        else
          format.html {render :edit_profile}
          format.json {render json: @user.errors, status: :unprocessable_entity}
        end
      end
    else
      flash[:error] = 'Access Denied!'
      redirect_to root_path
    end

  end


  def profile
    #  <!-- https://stackoverflow.com/questions/4765776/rails-show-posts-from-only-users-that-the-current-user-is-following -->
    @post = Item.where(:user_id => current_user.id)
    @bid_count=1
  end

  private

  def set_user_from_id
    @user = User.find(params[:user_id])
  end

  def user_params
    params.require(:user).permit(:username, :first_name, :last_name,
                                 :email, :cell_phone_no, :avatar, :profession)
  end

end
