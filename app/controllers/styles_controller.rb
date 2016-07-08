class StylesController < ApplicationController
  def show
    @style = Style.find_by(slug: params[:style_slug])
    if @style && @style.spaces
      @spaces = @style.spaces
    else
      flash[:warning] = "This climate currently has no spaces."
      redirect_to root_url
    end
  end
end
