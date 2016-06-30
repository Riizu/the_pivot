require "rails_helper"

RSpec.feature "Visitor views individual space" do
  scenario "they can view one space" do
    space = create(:space, approved: true)
    visit space_path(space)

    expect(page).to have_content space.name
    expect(page).to have_content space.price
    expect(page).to have_content space.description
    expect(page).to have_css("img[src=\"#{space.image_url.url(:medium)}\"]")
    expect(page).to have_button("Reserve this Space")
  end
end
