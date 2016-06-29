class SpacesController < ApplicationController
  def index
    @spaces = Space.all
  end

  def show
    @space = Space.find_by(slug: params[:space_slug])
  end
end
