require "rails_helper"

RSpec.feature "User edits existing space that they own" do
  context "Successfully update space data" do
    scenario "They edit from the space show page" do
      user = create(:user)
      space = create(:space, approved: true)
      user.spaces << space
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      login(user)
      visit space_path(space)
      click_on "Edit Space"

      expect(current_path).to eq edit_space_path(space)
      fill_in "Name", with: "New Name"
      fill_in "Nightly Rate", with: 123.45
      click_on "Update Space"

      expect(current_path).to eq space_path(space)
      expect(page).to have_content "New Name"
      expect(page).to have_content "$123.45"
    end
  end

  context "User can't edit spaces they don't own" do
    scenario "there is no edit button" do
      user, other_user = create_list(:user, 2)
      space = create(:space, approved: true)
      user.spaces << space
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(other_user)

      login(other_user)
      visit space_path(space)
      expect(page).to_not have_content "Edit Space"
    end

    scenario "they can't access manual path" do
      user, other_user = create_list(:user, 2)
      space = create(:space, approved: true)
      user.spaces << space
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(other_user)

      login(other_user)
      visit "/spaces/#{space.slug}/edit"

      expect(page).to have_content "You are not authorized to edit this space."
      expect(current_path).to eq space_path(space)
    end
  end
end
