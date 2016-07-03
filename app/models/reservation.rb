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
end
