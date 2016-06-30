require "rails_helper"

RSpec.feature "spaces can be approved" do
  scenario "user can't see an unapproved space" do
    space = create(:space)

    visit space_path(space)

    expect(current_path).to eq '/'
    expect(page).to have_content("That space is currently not available.")
  end

  scenario "user can see an approved space" do
    space = create(:space)
    space.update_attributes(approved: true)

    visit space_path(space)
    
    expect(page).to have_button("Reserve this Space")
  end
end
