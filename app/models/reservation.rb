class Reservation < ActiveRecord::Base
  belongs_to :space
  belongs_to :order

  def item_price
    space_price * quantity
  end
end
