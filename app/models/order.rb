class Order < ActiveRecord::Base
  belongs_to :user
  has_many :spaces, through: :reservations
  has_many :reservations

  def total_price
    reservations.map do |reservation|
      reservation.total_price
    end.reduce(:+)
  end

  def create_reservations(cart_reservations)
    cart_reservations.each do |reservation|
      self.reservations.create(space_id:   reservation.id,
                               total:      reservation.total,
                               start_date: reservation.start_date,
                               end_date:   reservation.end_date)
    end
  end
end
