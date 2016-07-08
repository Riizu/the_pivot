require "rails_helper"

RSpec.feature "Visitor adds a space to cart" do
  context "valid reservation" do
    scenario "visitor adds a valid reservation to the cart" do
      space = create(:space, approved: true)

      visit space_path(space)

      fill_in "start_date", with: "2016/08/17"
      fill_in "end_date", with: "2016/08/19"
      click_on "Reserve this Space"
      click_on "Cart"

      expect(current_path).to eq("/cart")

      within '#cart-spaces' do
        expect(page).to have_css("img[src=\"#{space.image_url.url(:thumb)}\"]")
        expect(page).to have_content(space.name)
        expect(page).to have_content(space.price)
        expect(page).to have_content(space.planet.name)
        expect(page).to have_content(space.style.name)
        expect(page).to have_content("August 17, 2016")
        expect(page).to have_content("August 19, 2016")
      end

      within '#total-cart-price' do
        expect(page).to have_content("Cart Total: $#{space.price * 2}")
        expect(page).to have_content("Total Spaces: 1")
      end
    end
  end

  context "invalid reservation" do
    scenario "visitor adds a valid reservation to the cart" do
      space = create(:space, approved: true)
      create(:reservation, space: space)

      visit space_path(space)

      fill_in "start_date", with: "2016/07/14"
      fill_in "end_date", with: "2016/07/16"
      click_on "Reserve this Space"

      expect(current_path).to eq(space_path(space))

      expect(page).to have_content("Your current date range is not available.")
    end
  end
end
