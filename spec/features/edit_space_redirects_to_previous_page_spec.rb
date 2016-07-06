require "rails_helper"

RSpec.feature "edit space redirects to previous page" do
  context "logged in as owner space" do
    scenario "returned to space show" do
      user = create(:user)
      space = create(:space, approved: true)
      user.spaces << space
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit space_path(space)
      click_on "Edit Space"

      fill_in "Occupancy", with: 90
      fill_in "Name", with: "The best name"
      click_on "Update Space"

      expect(current_path).to eq "/spaces/the-best-name"
    end
  end

  context "logged in as platform admin" do
    scenario "returned to all spaces" do
      admin = create(:user, role: 1)
      space = create(:space, approved: true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_spaces_path
      click_on "Edit"

      fill_in "Occupancy", with: 90
      fill_in "Name", with: "The best name"
      click_on "Update Space"

      expect(current_path).to eq admin_spaces_path
    end
  end
end
