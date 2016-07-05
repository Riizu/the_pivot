require "rails_helper"

RSpec.feature "user can add other users as hosts of their space" do
  context "they add an existing user" do
    scenario "that user can edit space" do
    user_1, user_2 = create_list(:user, 2)
    space = create(:space, approved: true)
    user_1.spaces << space
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit edit_space_path(space)

    click_button "Add Another Host"

    expect(current_path).to eq "/hosts/#{space.slug}/new"
    fill_in "New Host", with: user_2.username
    click_on "Add this host!"
    expect(current_path).to eq edit_space_path(space)
    end
  end
end
