class Admin::SpacesController < Admin::BaseController
  def index
    @spaces = Space.all
  end

  def new
    @space = Space.new
  end

  def create
    @space = Space.new_space(space_params)
    if @space.save
      flash[:success] = "Successfully created new space!"
      redirect_to admin_spaces_path
    else
      flash.now[:error] = @space.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
    @space = Space.find(params[:id])
  end

  def update
    @space = Space.find(params[:id])
    if @space.update_space(space_params)
      flash[:success] = "Successfully updated space!"
      redirect_to admin_spaces_path
    else
      flash.now[:error] = @space.errors.full_messages.join(", ")
      render :edit
    end
  end
  private

  def space_params
    params.require(:space).permit(:name, :price, :image_url, :foot, :style, :planet)
  end
end
