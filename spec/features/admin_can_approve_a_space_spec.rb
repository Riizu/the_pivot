require "rails_helper"

RSpec.feature "admin can edit a space" do
  scenario "they can edit space information" do
    admin = create(:user, role: 1)
    space = create(:space)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "admin/dashboard"

    click_link "All Unapproved Spaces"

    click_on "Approve"

    expect(current_path).to eq(admin_unapproved_spaces_path)
    expect(page).to_not have_content(space.name)
  end
end
