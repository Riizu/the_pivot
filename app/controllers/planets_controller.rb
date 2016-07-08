class PlanetsController < ApplicationController
  def index
  end

  def show
    @planet = Planet.find_by(slug: params[:planet_slug], active: true)

    if @planet && @planet.spaces
      @spaces = @planet.spaces
    else
      flash[:warning] = "This planet currently has no spaces."
      redirect_to root_url
    end
  end

  private

  def planet_params
    params.require(:planet).permit(:name)
  end

end
