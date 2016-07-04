class Admin::SpacesController < Admin::BaseController

  def index
    @spaces = Space.all
  end

end
