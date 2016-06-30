require 'rails_helper'

RSpec.feature "guest user sees spaces" do
  scenario "they see spaces on the index page" do
    space_one = create(:space)
    space_two = create(:space)

    visit '/spaces'

    expect(page).to have_content(space_one.name)
    expect(page).to have_content(space_one.price)
    expect(page).to have_content(space_one.description)
    expect(page).to have_content(space_two.name)
    expect(page).to have_content(space_one.price)
    expect(page).to have_content(space_two.description)
  end
end
