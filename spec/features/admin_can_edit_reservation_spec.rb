require "rails_helper"

RSpec.feature "admin can edit reservations" do
  context "admin successfully edits reservation" do
    scenario "they are returned to reservation index" do
      admin = create(:user, role: 1)
      reservation = create(:reservation)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit "/admin/dashboard"

      click_on "All Reservations"
      click_on "Edit"

      expect(current_path).to eq edit_admin_reservation_path(reservation)

      fill_in "Total Cost", with: 20
      click_on "Update Reservation"

      expect(current_path).to eq admin_reservations_path
      expect(page).to have_content(20)
    end
  end
end
