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
    #ADD SOME RESERVATIONS, PUNK
  end
end
