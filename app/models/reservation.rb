class Reservation < ActiveRecord::Base
  belongs_to :space
  belongs_to :order
  validates_with DateValidator

  def total_nights
    (end_date - start_date) / 60 / 60 / 24
  end

  def total_price
    total_nights * space.price
  end

  def toggle_active
    self.active = !self.active
    save
  end

  def update_reservation(reservation_params)
    update( space:       Space.find_by(name: reservation_params[:reservation][:space]),
            total:       reservation_params[:reservation][:total],
            start_date:  reservation_params[:reservation][:start_date],
            end_date:    reservation_params[:reservation][:end_date]
          )
  end

end
