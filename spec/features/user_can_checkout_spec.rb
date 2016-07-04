require 'rails_helper'

RSpec.feature "User can checkout" do
  context "valid" do
    scenario "redirected to order show page" do
      user = create(:user)
      space = create(:space, approved: true)
      login(user)
      add_to_cart(space, 3)

      visit '/cart'

      expect(page).to have_content("$7.00, Planet: 7_planet, Climate: 8_style Start Date: 2016/08/03 End Date: 2016/08/05")

      click_on "Checkout"

      expect(current_path).to eq('/charges/new')
    end
  end
end
