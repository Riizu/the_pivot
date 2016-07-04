require "rails_helper"

RSpec.feature "admin can go to all listings view" do
  scenario "they view all listings table" do
    admin = create(:user, role: 1)
    space = create(:space)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "admin/dashboard"

    click_on "All Listings"

    expect(page).to have_content("Name")
    expect(page).to have_content("Price")
    expect(page).to have_content("Climate")
    expect(page).to have_content("Planet")
    expect(page).to have_content("Description")
    expect(page).to have_content("Occupancy")
    expect(page).to have_content("Approved")

    expect(page).to have_content(space.name)
    expect(page).to have_content(space.price)
    expect(page).to have_content(space.style_id)
    expect(page).to have_content(space.planet_id)
    expect(page).to have_content(space.description)
    expect(page).to have_content(space.occupancy)
    expect(page).to have_content(space.approved)
  end
end
