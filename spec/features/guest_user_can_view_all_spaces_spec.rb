require 'rails_helper'

RSpec.feature "guest user sees spaces" do
  scenario "they see spaces on the index page" do
    planet = create(:planet)
    space_one = create(:space, planet: planet, approved: true)
    space_two = create(:space, planet: planet, approved: true)

    visit "/"
    fill_in "planet", with: planet.name
    click_button "search"
    
    expect(page).to have_content(space_one.name)
    expect(page).to have_content(space_one.price)
    expect(page).to have_content(space_one.description)
    expect(page).to have_content(space_two.name)
    expect(page).to have_content(space_one.price)
    expect(page).to have_content(space_two.description)
  end
end
