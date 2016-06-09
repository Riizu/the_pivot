class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash.now[:error] = @user.errors.full_messages.join(", ")
      render :new
      # redirect_to new_user_path
    end
  end

  def show
    if current_user
      @user = current_user
    else
      render file: 'public/404'
    end
  end

private
  def user_params
    params.require(:user).permit(:name, :username, :password, :password_confirmation)
  end
end
