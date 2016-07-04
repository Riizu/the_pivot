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

  # scenario "total price finds total of all items in order for multiple types of items" do
  #   user = create(:user)
  #   order = Order.create(user_id: user.id, status: "ordered")
  #   space1, space2 = create_list(:space, 2)
  #   reservation_1 = order.reservations.create(space_id: space1.id, quantity: 3, space_price: space1.price)
  #   reservation_2 = order.reservations.create(space_id: space2.id, quantity: 5, space_price: space2.price)
  #   expect(order.total_price).to eq(reservation_1.quantity * reservation_1.space_price + reservation_2.quantity * reservation_2.space_price)
  # end

  # scenario "total quantity finds sum of all items in order" do
  #   user = create(:user)
  #   order = Order.create(user_id: user.id, status: "ordered")
  #   space1, space2 = create_list(:space, 2)
  #   reservation_1 = order.reservations.create(space_id: space1.id, quantity: 3, space_price: space1.price)
  #   reservation_2 = order.reservations.create(space_id: space2.id, quantity: 5, space_price: space2.price)
  #   expect(order.total_quantity).to eq(reservation_1.quantity + reservation_2.quantity)
  # end
end
