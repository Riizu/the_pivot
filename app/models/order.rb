class Order < ActiveRecord::Base
  belongs_to :user
  has_many :spaces, through: :reservations
  has_many :reservations

  def total_price
    reservations.map do |reservation|
      reservation.quantity * reservation.space_price.to_f
    end.reduce(:+)
  end

  def total_quantity
    reservations.map(&:quantity).reduce(:+)
  end

  def create_reservations(cart_contents)
    cart_contents.map do |space_id, quantity|
      Reservation.create(order_id:    id,
                       space_id:     space_id,
                       total:  Space.find(space_id).price)
    end
  end

  def updated
    if status == "completed" || status == "cancelled"
      "This order was updated to the status of #{status} at
      #{updated_at.strftime('%A, %B %d, %Y at %I:%M%p')}."
    end
  end
end
