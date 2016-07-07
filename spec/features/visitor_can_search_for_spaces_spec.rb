require 'rails_helper'

RSpec.feature "visitor can search for spaces" do
  scenario "they enter a valid search query into the homepage search" do
    planet = create(:planet)
    user = create(:user)
    spaces = create_list(:space, 4, planet: planet, approved: true)
    user.spaces << spaces
    # unmatching_space_1 = create(:space, planet: planets[1], approved: true)
    # unmatching_space_2 = create(:space, planet: planets[0], approved: true)
    # create(:reservation, space: unmatching_space_2)



    visit '/'
    fill_in "planet", with: planet.name
    fill_in "occupancy", with: 0
    fill_in "start_date", with: "2016/07/15"
    fill_in "end_date", with: "2016/07/18"
    click_button "search"

    expect(current_path).to eq '/spaces'
    expect(page).to have_content(spaces[0].name)
    expect(page).to have_content(spaces[1].name)
    expect(page).to have_content(spaces[2].name)
    expect(page).to have_content(spaces[3].name)
    # expect(page).to_not have_content(unmatching_space_1.name)
    # expect(page).to_not have_content(unmatching_space_2.name)
  end

  scenario "They enter a search that invalidates a space by planet" do
    planet_1 = create(:planet)
    planet_2 = create(:planet)
    user = create(:user)
    valid_space = create(:space, planet: planet_1, approved: true)
    invalid_space = create(:space, planet: planet_2, approved: true)
    user.spaces << valid_space << invalid_space

    visit '/'
    fill_in "planet", with: planet_1.name
    fill_in "occupancy", with: 0
    fill_in "start_date", with: "2016/07/15"
    fill_in "end_date", with: "2016/07/18"
    click_button "search"

    expect(current_path).to eq '/spaces'
    expect(page).to have_content(valid_space.name)
    expect(page).to_not have_content(invalid_space.name)
  end

  scenario "They enter a search that invalidates a space by reservation" do
    planet = create(:planet)
    user = create(:user)
    valid_space = create(:space, planet: planet, approved: true)
    invalid_space = create(:space, planet: planet, approved: true)
    user.spaces << valid_space << invalid_space
    create(:reservation, space: invalid_space)

    visit '/'
    fill_in "planet", with: planet.name
    fill_in "occupancy", with: 0
    fill_in "start_date", with: "2016/07/15"
    fill_in "end_date", with: "2016/07/18"
    click_button "search"

    expect(current_path).to eq '/spaces'
    expect(page).to have_content(valid_space.name)
    expect(page).to_not have_content(invalid_space.name)
  end

  scenario "They enter a search that has no results" do
    planet = create(:planet)

    visit '/'
    fill_in "planet", with: planet.name
    fill_in "occupancy", with: 0
    fill_in "start_date", with: "2016/07/15"
    fill_in "end_date", with: "2016/07/18"
    click_button "search"

    expect(current_path).to eq '/'
    expect(page).to have_content("There were no valid search results.")
  end
end
