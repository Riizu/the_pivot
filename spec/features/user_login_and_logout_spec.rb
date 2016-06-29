require "rails_helper"

RSpec.feature "User Logs In and Logs Out" do
  context "Login tests" do
    scenario "existing user can login" do
    User.create(name: "Charlie", username: "Charlie123", password: "password", email: "charlie@example.com", phone_number: "123-456-7890")
    visit login_path
    fill_in "Username", with: "Charlie123"
    fill_in "Password", with: "password"
    click_button "Login"

    assert page.has_content?("Charlie")
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
    User.create(name: "Charlie", username: "Charlie123",
                       password: "password", email: "charlie@example.com", phone_number: "012-345-5678")

    visit login_path
    fill_in "Username", with: "Charlie123"
    fill_in "Password", with: "notmypassword"
    click_button "Login"

    assert page.has_content?("Invalid login. Please try again.")
    assert page.has_content?("Login")
    end
  end

  context "logout test" do
    scenario "user is returned to login page" do
    User.create(name: "Charlie", username: "Charlie123", password: "password", email: "charlie@example.com", phone_number: "123-456-7890")
    visit login_path
    fill_in "Username", with: "Charlie123"
    fill_in "Password", with: "password"
    click_button "Login"

    assert page.has_content?("Charlie")

    click_link "Charlie"
    click_link "Logout"

    assert page.has_content?("Goodbye!")
    assert page.has_content?("Login")
    end
  end
end
