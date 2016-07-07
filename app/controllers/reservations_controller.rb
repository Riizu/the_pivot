class ReservationsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    space = Space.find(params[:space_id])
    reservation = Reservation.new(space_id: space.id, start_date: params[:start_date], end_date: params[:end_date])
    if reservation.valid?
      @cart.add_reservation(space.id, space.price, params[:start_date], params[:end_date])
      session[:cart] = @cart.contents
      flash[:success] = "#{space.name} has been reserved and stashed in your cart!  Please proceed to your cart when you are ready to complete this booking!"
      redirect_to space_path(space)
    else
      flash[:notice] = "Your current date range is not available."
      redirect_to space_path(space)
    end
  end

  def show
    @reservations = @cart.reservations
  end

  def destroy
    space = Space.find(params[:id])
    @cart.remove_reservation(space.id)
    link = %Q[<a href="/spaces/#{space.slug}"> #{space.name}</a>]
    flash[:success] = "Your reservation for #{link} has been removed from this trip."
    redirect_to "/cart"
  end

  def update
    space = Space.find(params[:id])
    @cart.update_quantity(space.id, params[:direction])
    redirect_to "/cart"
  end
end
