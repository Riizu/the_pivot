require 'rails_helper'

RSpec.describe Reservation, type: :model do
  scenario "item price multiplies quantity and space price" do
    ordered_space = Reservation.new(space_id: 1, order_id: 1, quantity: 3, space_price: 5.99)
    expect(ordered_space.item_price).to eq(ordered_space.space_price * ordered_space.quantity)
  end
end
