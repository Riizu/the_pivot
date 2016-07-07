class Admin::UsersController < Admin::BaseController
  def show
    @admin = current_user
    @unapproved_spaces = Space.where(approved: false)
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if params[:change_active] == "true"
      @user.toggle_active
    else
      flash[:error] = "The user was not successfully updated."
    end
      redirect_to admin_users_path
  end
end
