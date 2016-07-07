require "rails_helper"

RSpec.feature "visitor removes space from cart" do
  context "spaces are in a visitors cart" do
    scenario "visitor can successfully remove spaces from the cart" do
      space = create(:space, approved: true)
      add_to_cart(space)

      visit "/cart"

      expect(page).to have_content("Cart Total: $#{space.price*2}")

      click_button "Remove"

      expect(current_path).to eq("/cart")
      expect(page).to have_css("#flash_success")
      expect(page).to have_content("Your reservation for #{space.name} has been removed from this trip.")
      expect(page).to have_link("#{space.name}")

      expect(page).to have_content("Cart Total: $0.00")
    end
  end
end
