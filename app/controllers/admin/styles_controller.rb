class Admin::StylesController < Admin::BaseController

  def index
    @styles = Style.all
  end

  def edit
    @style = Style.find_by(slug: params[:id])
  end
end
