require "rails_helper"

RSpec.feature "User can submit a new space" do
  context "valid space attributes" do
    scenario "the space is submitted for approval" do
        planet = create(:planet)
        style = create(:style)
        user = create(:user)
        login(user)
        click_on user.first_name
        click_on "Dashboard"
        click_on "Post Your Space!"

        expect(current_path).to eq new_space_path

        fill_in "Name", with: "My Awesome Crib"
        fill_in "Description", with: "My new crib is so cool.  You should definitely stay here and pay me stacks!!!"
        fill_in "Occupancy", with: 6
        fill_in "Nightly Rate", with: 49.99
        select "#{planet.name}", from: "Planet"
        select "#{style.name}", from: "Climate"
        click_on "Create Space"

        expect(current_path).to eq "/dashboard"
        expect(page).to have_content "Your space has successfully been submitted for approval!"
    end
  end

  context "invalid space attributes" do
    scenario "the new space page is rendered with a flash message" do
        planet = create(:planet)
        style = create(:style)
        user = create(:user)
        login(user)
        click_on user.first_name
        click_on "Dashboard"
        click_on "Post Your Space!"

        expect(current_path).to eq new_space_path

        fill_in "Name", with: ""
        fill_in "Description", with: "My new crib is so cool.  You should definitely stay here and pay me stacks!!!"
        fill_in "Occupancy", with: 6
        fill_in "Nightly Rate", with: 49.99
        select "#{planet.name}", from: "Planet"
        select "#{style.name}", from: "Climate"
        click_on "Create Space"

        expect(current_path).to_not eq "/dashboard"
        expect(page).to have_content "Name can't be blank"
    end
  end

  context "guest can't create new space" do
    scenario "they are redirected to login page" do
      visit "/spaces/new"

      expect(page).to have_content "You must be logged in to post a space."
      expect(current_path).to eq login_path
    end
  end
end
