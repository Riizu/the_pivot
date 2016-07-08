require "rails_helper"

RSpec.feature "admin can go to all reservations view" do
  scenario "they view all reservations table" do
    admin = create(:user, role: 1)
    reservation = create(:reservation)
    start_date = Time.parse(reservation.start_date.to_s).strftime("%D")
    end_date = Time.parse(reservation.end_date.to_s).strftime("%D")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "admin/dashboard"

    click_on "All Reservations"

    expect(page).to have_content("All Reservations")
    expect(page).to have_content("Space")
    expect(page).to have_content("Owner")
    expect(page).to have_content("Guest")
    expect(page).to have_content("Check in")
    expect(page).to have_content("Check out")
    expect(page).to have_content("Total")
    expect(page).to have_content("Edit")
    expect(page).to have_content("Deactivate")

    expect(page).to have_content(reservation.space.name)
    expect(page).to have_content(start_date)
    expect(page).to have_content(end_date)
    expect(page).to have_content(reservation.total)
  end
end
