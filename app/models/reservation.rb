class Reservation < ActiveRecord::Base
  belongs_to :space
  belongs_to :order

  def item_price
    space_price * quantity
    #quantity would be occupency, right? Where is that in schema
  end
end
