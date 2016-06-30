require "rails_helper"

RSpec.feature "Visit adds a space to cart" do
  context "visitor views a space" do
    scenario "visitor adds that space to the cart" do
      space = create(:space, approved: true)

      visit space_path(space)
      click_on "Reserve this Space"
      click_on "Cart"

      expect(current_path).to eq("/cart")

      within '#cart-spaces' do
        expect(page).to have_css("img[src=\"#{space.image_url.url(:thumb)}\"]")
        expect(page).to have_content(space.name)
        expect(page).to have_content(space.price)
        expect(page).to have_content(space.planet.name)
        expect(page).to have_content(space.style.name)
      end

      within '#total-cart-price' do
        expect(page).to have_content("Cart Total: $#{space.price}")
        expect(page).to have_content("Total Items in Cart: 1")
      end
    end
  end
end
