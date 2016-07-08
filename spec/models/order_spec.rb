require 'rails_helper'

RSpec.describe Order, type: :model do
  scenario "creates order items from cart contents" do
    space1, space2, space3 = create_list(:space, 3)
    user = create(:user)
    cart = Cart.new({ space1.id.to_s => ["3.0", "2016/12/01", "2016/12/03"], space2.id.to_s => ["3.0", "2016/12/03", "2016/12/05"], space3.id.to_s => ["3.0", "2016/12/05", "2016/12/07"] })
    order = Order.create(user_id: user, status: "ordered")
    expect(Reservation.all.count).to eq(0)
    order.create_reservations(cart.reservations)
    expect(Reservation.all.count).to eq(3)
  end

  scenario "total price finds total of all items in order for multiple types of items" do
    order = create(:order)
    reservation_1 = create(:reservation, order: order)
    reservation_2 = create(:reservation, order: order)
    expect(order.total_price).to eq(reservation_1.total_price + reservation_2.total_price)
  end

end
