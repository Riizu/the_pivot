class Admin::UsersController < Admin::BaseController
  def show
    @admin = current_user
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end
end
