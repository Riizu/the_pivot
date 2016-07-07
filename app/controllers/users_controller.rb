class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      route_by_user_role
    else
      flash[:error] = @user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end

  def show
    @user = User.find_by(username: params[:username], active: true)
    @search_hash = {username: params[:username]}
    if @user && @user.spaces
      @spaces = @user.spaces
    else
      flash[:warning] = "This user currently has no spaces."
      redirect_to root_url
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      route_update_for_user
    else
      flash.now[:error] = @user.errors.full_messages.join(", ")
      render :edit
    end
  end

  def route_update_for_user
    if @user.admin?
      redirect_to admin_dashboard_path
    else
      redirect_to dashboard_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :password, :password_confirmation, :email, :email_confirmation, :phone_number)
  end
end
