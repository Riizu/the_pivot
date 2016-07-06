class Admin::SpacesController < Admin::BaseController

  def index
    @spaces = Space.all
  end

  def edit
    @space = Space.find(params[:id])
    session[:return_to] = request.referer
  end

  def update
    @space = Space.find(params[:id])
    if @space.update_space(space_params)
      flash[:success] = "You space has been successfully updated!"
      redirect_to session[:return_to]
    else
      flash.now[:error] = @space.errors.full_messages.join(", ")
      render :edit
    end
  end

end
