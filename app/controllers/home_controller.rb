class HomeController < ApplicationController
  respond_to :json

  def show
  end

  def index
    @planet_names = Planet.where(active: true)
    respond_with @planet_names
  end
end
