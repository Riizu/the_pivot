require 'rails_helper'

RSpec.feature "visitor browses planet" do
  scenario "visitor sees spaces in a specific planet" do
    space_1, space_2 = create_list(:space, 2)
    planet = space_1.planet.slug
    visit "/planets/#{planet}"
    
    within '.one-planet' do
      expect(page).to have_link(space_1.name, href: space_path(space_1))
      expect(page).to have_content space_1.price
      expect(page).to have_css("img[src=\"#{space_1.image_url.url(:medium)}\"]")
      expect(page).to_not have_link(space_2.name, href: space_path(space_2))
    end
  end
end
