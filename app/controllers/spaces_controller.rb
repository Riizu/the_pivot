class SpacesController < ApplicationController
  def index
    if planet = Planet.find_by(name: params[:planet])
      @spaces = Space.where("planet_id = ? AND occupancy >= ?", planet.id, params[:occupancy].to_i)
    else
      flash[:warning] = "Please include a planet"
      redirect_to root_url
    end
  end

  def show
    @space = Space.find_by(slug: params[:space_slug])
  end
end
