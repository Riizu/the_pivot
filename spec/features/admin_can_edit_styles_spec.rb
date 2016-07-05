require "rails_helper"

RSpec.feature "admin can edit a style" do
  scenario "they can edit style information" do
    admin = create(:user, role: 1)
    style = create(:style)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "admin/dashboard"

    click_on "All Climates"
    click_on "Edit #{style.name}"

    expect(current_path).to eq("/admin/styles/#{style.slug}/edit")

    fill_in "Name", with: "New Name"
    click_on "Update Style"

    expect(current_path).to eq(admin_styles_path)

    expect(page).to have_content("New Name")
    expect(page).to_not have_content(style.name)
  end
end
