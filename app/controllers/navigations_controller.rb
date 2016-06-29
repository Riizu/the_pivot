class NavigationsController < ApplicationController
  def show
    planet = Planet.find_by_slug(params[:id])
    style = Style.find_by_slug(params[:id])
    route_planet_or_style(planet, style)
  end

  def route_planet_or_style(planet, style)
    if planet
      @title = planet.name
      @spaces = planet.spaces
    elsif style
      @title = style.name
      @spaces = style.spaces
    else
      render file: "public/404"
    end
  end
end
