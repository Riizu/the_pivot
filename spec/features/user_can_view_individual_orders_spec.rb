require "rails_helper"

RSpec.feature "an existing user can view their individual past orders" do
  scenario "they are redirected to order path" do
    user = create(:user)
    order_1 = Order.create(user_id: user.id)
    login(user)
    visit "/orders"

    click_link order_1.id.to_s

    expect(current_path).to eq order_path(order_1)
    expect(page).to have_content(order_1.id)
  end

  scenario "they see relevant reservations for the order" do
    reservation = create(:reservation)
    user = reservation.order.user

    login(user)
    visit "/orders"

    click_link user.orders.first.id
    expect(current_path).to eq order_path(user.orders.first)
    expect(page).to have_content(user.orders.first.id)
    expect(page).to have_content(user.orders.first.spaces.name)
    expect(page).to have_content(user.orders.first.reservations.first.total)
    expect(page).to have_content(user.orders.first.reservations.first.total * user.orders.first.spaces.first.occupancy)

  end
end
