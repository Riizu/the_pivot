require 'rails_helper'

RSpec.feature "Admin can edit a user" do
  scenario "they visit the users table" do
    admin = create(:user, role: 1)
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "admin/dashboard"

    click_on "All Users"

    within "#row-#{user.username}" do
      click_on "Edit"
    end

    expect(current_path).to eq "/admin/users/#{user.id}/edit"

    fill_in "Username", with: "test_user"
    click_on "Update User"

    visit '/admin/users'

    expect(page).to have_content("test_user")

  end
end
