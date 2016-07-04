class Admin::PlanetsController < Admin::BaseController

  def index
    @planets = Planet.all
  end

end
