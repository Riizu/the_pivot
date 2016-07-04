require "rails_helper"

RSpec.feature "admin can go to all planets view" do
  scenario "they view all planets table" do
    admin = create(:user, role: 1)
    planet = create(:planet)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "admin/dashboard"

    click_on "All Planets"

    expect(page).to have_content("Name")
    expect(page).to have_content("Edit")
    expect(page).to have_content("Delete")

    expect(page).to have_content(planet.name)
  end
end
