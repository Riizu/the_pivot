require "rails_helper"

RSpec.feature "admin can go to all climates view" do
  scenario "they view all climates table" do
    admin = create(:user, role: 1)
    style = create(:style)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "admin/dashboard"

    click_on "All Climates"

    expect(page).to have_content("All Climates")
    expect(page).to have_content("Name")
    expect(page).to have_content("Edit")

    expect(page).to have_content(style.name)
  end
end
