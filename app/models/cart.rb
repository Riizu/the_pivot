class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def add_reservation(space_id, price, start_date, end_date)
    contents[space_id.to_s] ||= []
    contents[space_id.to_s] = [price, start_date, end_date]
  end

  def total
    contents.count
  end

  def reservations
    contents.map do |id, values|
      space = Space.find(id)
      CartReservation.new(space, values[0], values[1], values[2])
    end
  end

  def total_price
    reservations.reduce(0) do |total, reservation|
      total + reservation.price.to_d * (reservation.night_count)
    end
  end

  def remove_reservation(space_id)
    contents.delete_if { |id, _quantity| id == space_id.to_s }
  end

  def one?(id)
    contents[id.to_s] == 1
  end
end
