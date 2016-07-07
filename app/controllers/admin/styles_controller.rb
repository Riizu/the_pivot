class Admin::StylesController < Admin::BaseController

  def index
    @styles = Style.all
  end

  def edit
    @style = Style.find_by(slug: params[:id])
  end

  def update
    @style = Style.find_by(slug: params[:id])
    if params[:change_active] == "true"
      if @style.no_dependencies?
        @style.delete
      else
        flash.now[:error] = "That style has dependencies."
      end
      redirect_to admin_styles_path
    elsif @style.update(name: params[:style]["name"])
      flash[:success] = "The style has been successfully updated!"
      redirect_to admin_styles_path
    else
      flash.now[:error] = @planet.errors.full_messages.join(", ")
      render :edit
    end
  end
end
