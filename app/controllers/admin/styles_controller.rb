class Admin::StylesController < Admin::BaseController

  def index
    @styles = Style.all
  end

end
