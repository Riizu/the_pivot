require "rails_helper"

RSpec.feature "admin can edit a space" do
  scenario "they can edit space information" do
    admin = create(:user, role: 1)
    space = create(:space, approved: true)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "admin/dashboard"

    click_on "All Spaces"

    click_on "Edit"

    expect(current_path).to eq(edit_admin_space_path(space.id))

    fill_in "Name", with: "New Name"

    click_on "Update Space"

    expect(current_path).to eq("/spaces/new-name")

    expect(page).to have_content("New Name")
    expect(page).to_not have_content(space.name)
  end
end
