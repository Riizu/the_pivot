class HomeController < ApplicationController
  respond_to :json

  def show

  end

  def index
    @planet_names = Planet.all
    respond_with @planet_names
  end
end
