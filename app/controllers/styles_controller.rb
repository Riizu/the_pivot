class StylesController < ApplicationController
  def index

  end

  def show
    @style = Style.find_by(slug: params[:style_slug])

    if @style && @style.spaces
      @spaces = @style.spaces
    else
      flash[:warning] = "This climate currently has no spaces."
      redirect_to root_url
    end
  end

  def update
    @style = Style.find_by(slug: params[:slug])
    @style.update(name: params[:style]["name"])
    flash[:success] = "The style has been successfully updated!"
    redirect_to admin_styles_path
  end
end
