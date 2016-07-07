require "rails_helper"

RSpec.feature "admin can edit a planet" do
  scenario "they can edit planet information" do
    admin = create(:user, role: 1)
    planet = create(:planet)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "admin/dashboard"
    click_on "All Planets"
    click_on "Edit"

    expect(current_path).to eq(edit_admin_planet_path(planet.id))
    fill_in "Name", with: "Pluto"

    click_on "Update Planet"

    expect(current_path).to eq planet_path(planet)

    expect(page).to have_content("Pluto")
    expect(page).to_not have_content(planet.name)
  end
end
