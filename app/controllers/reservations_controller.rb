class ReservationsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    space = Space.find(params[:space_id])
    reservation = Reservation.new(space_id: space.id, start_date: params[:start_date], end_date: params[:end_date])
    if reservation.valid?
      @cart.add_reservation(space.id, space.price, params[:start_date], params[:end_date])
      session[:cart] = @cart.contents
      flash[:notice] = "Your cart has #{@cart.count_of(space.id)} of #{space.name.pluralize(@cart.count_of(space.id))}."
      redirect_to space_path(space)
    else
      flash[:notice] = "That date range is invalid."
      redirect_to space_path(space)
    end
  end

  def show
    @reservations = @cart.reservations
  end

  def destroy
    space = Space.find(params[:id])
    @cart.remove_reservation(space.id)
    link = %Q[<a href="/spaces/#{space.id}"> #{space.name.pluralize(@cart.count_of(space.id))}</a>]
    flash[:success] = "Successfully removed #{link} from your cart."
    redirect_to "/cart"
  end

  def update
    space = space.find(params[:id])
    @cart.update_quantity(space.id, params[:direction])
    redirect_to "/cart"
  end
end
