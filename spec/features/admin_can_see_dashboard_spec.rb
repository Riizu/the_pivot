require "rails_helper"

RSpec.feature "admin can view dashbaord" do
  scenario "they view info for trips/listings" do
    admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "admin/dashboard"

    expect(page).to have_link("All Reservations")
    expect(page).to have_link("All Spaces")
    expect(page).to have_link("All Planets")
    expect(page).to have_link("All Climates")
  end
end
