require "rails_helper"

RSpec.feature "User Logs In and Logs Out" do
  context "Login tests" do
    scenario "existing user can login" do
      user = create(:user)
      visit login_path
      fill_in "Username", with: user.username
      fill_in "Password", with: "password"
      click_button "Login"

      assert page.has_content?(user.first_name)
    end

    scenario "guest cannot login" do
      visit login_path
      fill_in "Username", with: "Clarence"
      fill_in "Password", with: "password"
      click_button "Login"

      assert page.has_content?("Invalid login. Please try again.")
      assert page.has_content?("Login")
    end

    scenario "registered user cannot login with wrong password" do
      user = create(:user)
      visit login_path
      fill_in "Username", with: user.username
      fill_in "Password", with: "notmypassword"
      click_button "Login"

      assert page.has_content?("Invalid login. Please try again.")
      assert page.has_content?("Login")
    end
  end

  context "logout test" do
    scenario "user is returned to login page" do
      user = create(:user)
      visit login_path
      fill_in "Username", with: user.username
      fill_in "Password", with: "password"
      click_button "Login"

      assert page.has_content?(user.first_name)

      click_link user.first_name
      click_link "Logout"

      assert page.has_content?("Successfully logged out")
      assert page.has_content?("Login")
    end
  end
end
