require "rails_helper"

RSpec.feature "logged in user can view dashbaord" do
  scenario "they view user info and trips/listings" do
    user = create(:user)
    login(user)
    order = create(:order)
    User.orders.create(order)
    click_on user.name
    click_on "Dashboard"

    expect(current_path).to eq "/dashboard"

    click_on "My Trips"

    expect(current_path).to eq orders_path
  end
end
