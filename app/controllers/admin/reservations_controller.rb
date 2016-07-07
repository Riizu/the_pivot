class Admin::ReservationsController < Admin::BaseController

  def index
    @reservations = Reservation.all
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    if params[:change_active] == "true"
      @reservation.toggle_active
      redirect_to admin_reservations_path
    elsif @reservation.update_reservation(params)
      flash[:success] = "The reservation was successfully updated!"
      redirect_to admin_reservations_path
    else
      flash.now[:error] = @reservation.errors.full_messages.join(", ")
      render :edit
    end
  end
end
