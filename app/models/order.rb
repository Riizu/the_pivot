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

  def create_reservations(cart_reservations)
    cart_reservations.each do |reservation|
      self.reservations.create(space_id:   reservation.id,
                               total:      reservation.total,
                               start_date: reservation.start_date,
                               end_date:   reservation.end_date)
    end
  end

  def updated
    if status == "completed" || status == "cancelled"
      "This order was updated to the status of #{status} at
      #{updated_at.strftime('%A, %B %d, %Y at %I:%M%p')}."
    end
  end
end
