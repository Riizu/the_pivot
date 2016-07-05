require "rails_helper"

RSpec.feature "logged in user can view dashbaord" do
 scenario "they view user info and trips/listings" do
   user = create(:user_with_orders)
   login(user)
   click_on user.first_name
   click_on "Dashboard"

   expect(current_path).to eq "/dashboard"

   click_on "My Trips"

   expect(current_path).to eq orders_path
   expect(page).to have_content("You have 5 orders:")
   expect(page).to have_content("completed")
 end
end
