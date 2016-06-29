class CartSpacesController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    space = Space.find(params[:space_id])
    @cart.add_space(space.id)
    session[:cart] = @cart.contents
    flash[:notice] = "Your cart has #{@cart.count_of(space.id)} of #{space.name.pluralize(@cart.count_of(space.id))}."
    redirect_to space_path(space)
  end

  def show
    @spaces = @cart.spaces
  end

  def destroy
    space = Space.find(params[:id])
    @cart.remove_space(space.id)
    link = %Q[<a href="/spaces/#{space.id}"> #{space.name.pluralize(@cart.count_of(space.id))}</a>]
    flash[:success] = "Successfully removed #{link} from your cart."
    redirect_to "/cart"
  end

  def update
    space = Space.find(params[:id])
    @cart.update_quantity(space.id, params[:direction])
    redirect_to "/cart"
  end
end
