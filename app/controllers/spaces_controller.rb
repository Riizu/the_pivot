class SpacesController < ApplicationController
  def index
    if (params[:start_date] == "") || (params[:end_date] == "")
      flash[:warning] = "Please enter a date."
      redirect_to root_url
    elsif planet = Planet.find_by(name: params[:planet])
      @spaces = Space.where("planet_id = ? AND occupancy >= ?", planet.id, params[:occupancy].to_i)
      @spaces = @spaces.map do |space|
        if space.reservations.new(start_date: params[:start_date], end_date: params[:end_date]).valid?
          space
        end
      end.compact

      if @spaces.count > 0
        @styles = @spaces.map {|space| space.style.name }.uniq
        @styles.unshift("All Spaces")
        @search_hash = { planet: params[:planet], occupancy: params[:occupancy], start_date: params[:start_date], end_date: params[:end_date] }
      else
        flash[:warning] = "There were no valid search results."
        redirect_to root_url
      end
    else
      flash[:warning] = "Please include a planet"
      redirect_to root_url
    end
  end

  def show
    @space = Space.find_by(slug: params[:space_slug])
    if @space.approved
      @space
      @search_hash = { start_date: params[:check_in], end_date: params[:check_out] }
    else
      flash[:warning] = "That space is currently not available."
      redirect_to root_url
    end
  end

  def new
    if current_user
      @space = Space.new
    else
      flash[:warning] = "You must be logged in to post a space."
      redirect_to login_path
    end
  end

  def create
    @space = Space.new_space(space_params)
    if @space.save
      current_user.spaces << @space
      flash[:success] = "Your space has successfully been submitted for approval!"
      redirect_to "/dashboard"
    else
      flash.now[:error] = @space.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
    @space = Space.find_by(slug: params[:space_slug])
    if @space.users.include?(current_user)
      @space
      session[:return_to] = request.referer
    else
      flash[:warning] = "You are not authorized to edit this space."
      redirect_to space_path(@space)
    end
  end

  def update
    @space = Space.find_by(slug: params[:space_slug])
    if @space.update_space(space_params)
      flash[:success] = "Your space has been successfully updated!"
      redirect_to session[:return_to]
    else
      flash.now[:error] = @space.errors.full_messages.join(", ")
      render :edit
    end
  end

  private

  def space_params
    params.require(:space).permit(:name, :occupancy, :description, :price,
                                 :image_url, :style, :planet)
  end


end
