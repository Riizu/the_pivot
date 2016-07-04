require "rails_helper"

RSpec.feature "admin can go to all users view" do
  scenario "they view all users table" do
    admin = create(:user, role: 1)
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "admin/dashboard"

    click_on "All Users"

    expect(page).to have_content("All Users")
    expect(page).to have_content("ID")
    expect(page).to have_content("Username")
    expect(page).to have_content("First Name")
    expect(page).to have_content("Last Name")
    expect(page).to have_content("Role")
    expect(page).to have_content("Screen Name")
    expect(page).to have_content("UID")
    expect(page).to have_content("Email")
    expect(page).to have_content("Phone Number")

    expect(page).to have_content(user.id)
    expect(page).to have_content(user.username)
    expect(page).to have_content(user.first_name)
    expect(page).to have_content(user.last_name)
    expect(page).to have_content(user.role)
    expect(page).to have_content(user.screen_name)
    expect(page).to have_content(user.uid)
    expect(page).to have_content(user.email)
    expect(page).to have_content(user.phone_number)
  end
end
