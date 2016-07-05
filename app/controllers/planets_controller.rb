class PlanetsController < ApplicationController
  def index
  end

  def show
    @planet = Planet.find_by(slug: params[:planet_slug])

    if @planet && @planet.spaces
      @spaces = @planet.spaces
    else
      flash[:warning] = "This planet currently has no spaces."
      redirect_to root_url
    end
  end

  def update
    @planet = Planet.find_by(slug: params[:planets_slug])
    if @planet.update(planet_params)
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
