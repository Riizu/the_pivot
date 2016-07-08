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
      active_toggle_actions
    elsif @style.update(name: params[:style]["name"])
      flash[:success] = "The style has been successfully updated!"
      redirect_to admin_styles_path
    else
      flash.now[:error] = @planet.errors.full_messages.join(", ")
      render :edit
    end
  end

  private

    def active_toggle_actions
      if @style.no_dependencies?
        @style.delete
        flash[:success] = "This style has been deleted."
      else
        flash.now[:error] = "This style currently has spaces dependencies and cannot be deleted."
      end
      redirect_to admin_styles_path
    end

end
