class SpacesController < ApplicationController
  def index
    planet = Planet.find_by(name: params[:planet])
    @spaces = Space.where(planet: planet, occupancy: params[:occupancy])
  end

  def show
    @space = Space.find_by(slug: params[:space_slug])
  end
end
