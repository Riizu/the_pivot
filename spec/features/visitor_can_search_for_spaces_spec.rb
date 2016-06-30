require 'rails_helper'

RSpec.feature "visitor can search for spaces" do
  scenario "they enter a search query into the homepage search" do
    planet = create(:planet)
    unmatching_planet = create(:planet, name: "fake planet")
    spaces = create_list(:space, 4, planet: planet)
    unmatching_space = create(:space, planet: unmatching_planet)
    user = create(:user)
    user.spaces << spaces << unmatching_space

    visit '/'
    fill_in "planet", with: user.spaces[0].planet.name
    fill_in "occupancy", with: user.spaces[0].occupancy
    fill_in "start_date", with: "06/01/2016"
    fill_in "end_date", with: "06/03/2016"
    click_button "search"

    expect(current_path).to eq '/spaces'
    expect(page).to have_content(spaces[0].name)
    expect(page).to have_content(spaces[1].name)
    expect(page).to have_content(spaces[2].name)
    expect(page).to have_content(spaces[3].name)
    expect(page).to_not have_content(unmatching_space.name)
  end
end
