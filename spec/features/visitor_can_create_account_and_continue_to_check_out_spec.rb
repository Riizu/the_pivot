require "rails_helper"

RSpec.feature "visitor creates account to checkout" do
  context "valid information given" do
    scenario "visitor creates account" do
      space_1, space_2, space_3 = create_list(:space, 3, approved: true)
      add_to_cart(space_1)
      add_to_cart(space_2)
      add_to_cart(space_3)

      visit "/cart"

      expect(page).to_not have_button "Proceed to Checkout"
      expect(page).to have_button "Login or Create Account to Reserve Spaces"
      click_on "Login or Create Account to Reserve Spaces"

      click_button "Create Account"
      fill_in "First name", with: "Charlie"
      fill_in "Last name", with: "Kaminer"
      fill_in "Username", with: "c123"
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "password"
      fill_in "Email", with: "email@email.com"
      fill_in "Email confirmation", with: "email@email.com"
      fill_in "Phone number", with: "1234567890"
      click_on "Create Account"

      visit "/cart"
      expect(page).to have_content(space_1.name)
      expect(page).to have_content(space_2.name)
      expect(page).to have_content(space_3.name)

      click_on "Logout"

      expect(page).to have_content("Login")
      expect(page).to_not have_content("Logout")
    end
  end
end
