class Admin::SpacesController < Admin::BaseController

  def index
    @spaces = Space.all
  end

  def edit
    @space = Space.find(params[:id])
    session[:return_to] = request.referer
  end

  def update
    @space = Space.find_by(slug: params[:id])
    if params[:change_active] == "true"
      @space.toggle_active
      redirect_to admin_spaces_path
    elsif @space.update_space(space_params)
      flash[:success] = "You space has been successfully updated!"
      session[:return_to] ? (redirect_to session[:return_to]) : (redirect_to admin_spaces_path)
    else
      flash.now[:error] = @space.errors.full_messages.join(", ")
      render :edit
    end
  end

end
