class Admin::UsersController < Admin::BaseController
  def show
    @admin = current_user if current_admin?
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
    # byebug
    if params[:change_active] == "true"
      @user.toggle_active
      flash[:success] = "The user has been successfully deactivated."
    elsif @user.update(user_params)
      admin_dashboard_path
    else
      flash[:error] = "The user was not successfully updated."
    end
    redirect_to admin_users_path
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :email, :email_confirmation, :phone_number, :role)
    end

end
