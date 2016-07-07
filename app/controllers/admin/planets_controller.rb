class Admin::PlanetsController < Admin::BaseController
  def index
    @planets = Planet.all
  end

  def edit
    @planet = Planet.find(params[:id])
  end

  def update
    @planet = Planet.find_by(id: params[:id])
    if params[:change_active] == "true"
      @planet.toggle_active
      redirect_to admin_planets_path
    elsif @planet.update(planet_params)
      flash[:success] = "You planet has been successfully updated!"
      redirect_to planet_path(@planet)
    else
      flash.now[:error] = @planet.errors.full_messages.join(", ")
      render :edit
    end
  end

  private

  def planet_params
    params.require(:planet).permit(:name)
  end
end
