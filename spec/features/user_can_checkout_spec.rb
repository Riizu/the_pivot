require 'rails_helper'

RSpec.feature "User can checkout" do
  context "valid" do
    scenario "redirected to order show page" do
      user = create(:user)
      space = create(:space, approved: true)
      login(user)
      add_to_cart(space, 1)

      visit '/cart'

      expect(page).to have_content(space.price)
      expect(page).to have_content(space.planet.name)
      expect(page).to have_content(space.style.name)
      expect(page).to have_content("August 1, 2016")
      expect(page).to have_content("August 3, 2016")
      click_on "Checkout"

      expect(current_path).to eq('/charges/new')
    end
  end
end
