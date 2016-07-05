class Admin::PlanetsController < Admin::BaseController
  def index
    @planets = Planet.all
  end

  def edit
    @planet = Planet.find(params[:id])
  end
end
