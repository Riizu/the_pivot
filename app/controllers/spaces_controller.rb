class SpacesController < ApplicationController
  def index
    if planet = Planet.find_by(name: params[:planet])
      @spaces = Space.where("planet_id = ? AND occupancy >= ?", planet.id, params[:occupancy].to_i)
      @styles = @spaces.map {|space| space.style.name }.uniq
    else
      flash[:warning] = "Please include a planet"
      redirect_to root_url
    end
  end

  def show
    @space = Space.find_by(slug: params[:space_slug])
    if @space.approved
      @space
    else
      flash[:warning] = "That space is currently not available."
      redirect_to root_url
    end
  end
end
