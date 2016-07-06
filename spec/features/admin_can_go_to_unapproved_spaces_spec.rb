require 'rails_helper'

RSpec.feature "Admin can go to the unapproved spaces page" do
  scenario "They visit the admin dashboard" do
    admin = create(:user, role: 1)
    space = create(:space)
    approved_space = create(:space, approved: true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit '/admin/dashboard'
    click_link 'All Unapproved Spaces'

    expect(current_path).to eq("/admin/unapproved_spaces")

    expect(page).to have_content("All Unapproved Spaces")
    expect(page).to have_content("ID")
    expect(page).to have_content("Name")
    expect(page).to have_content("Price")
    expect(page).to have_content("Climate")
    expect(page).to have_content("Planet")
    expect(page).to have_content("Description")
    expect(page).to have_content("Occupancy")
    expect(page).to have_content("Approved")

    expect(page).to have_content(space.id)
    expect(page).to have_content(space.name)
    expect(page).to have_content(space.price)
    expect(page).to have_content(space.style_id)
    expect(page).to have_content(space.planet_id)
    expect(page).to have_content(space.description)
    expect(page).to have_content(space.occupancy)
    expect(page).to have_content(space.approved)

    expect(page).to_not have_content(approved_space.name)
  end
end
