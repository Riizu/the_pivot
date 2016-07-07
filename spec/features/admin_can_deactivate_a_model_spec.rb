require 'rails_helper'

RSpec.feature "The admin can deactivate various models" do
  context "Deactivate a model" do
    scenario "They deactivate a reservation" do
      admin = create(:user, role: 1)
      reservation = create(:reservation)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit '/admin/reservations'
      click_on "Deactivate"

      expect(current_path).to eq('/admin/reservations')
      expect(Reservation.find(reservation).active).to eq(false)
    end

    scenario "They deactivate a planet" do
      admin = create(:user, role: 1)
      planet = create(:planet)
      spaces = create_list(:space, 3, approved: true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit '/admin/planets'
      click_on "Deactivate"

      expect(current_path).to eq('/admin/planets')
      expect(planet.active).to eq(false)
      expect(spaces[0].active).to eq(false)
      expect(spaces[1].active).to eq(false)
      expect(spaces[2].active).to eq(false)
    end

    scenario "They deactivate a space" do
      admin = create(:user, role: 1)
      space = create(:space, approved: true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit '/admin/spaces'
      click_on "Deactivate"

      expect(current_path).to eq('/admin/spaces')
      expect(space.active).to eq(false)
    end

    scenario "They attempt to delete a style that has dependencies" do
      admin = create(:user, role: 1)
      style = create(:style)
      space = create(:space, style: style)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit '/admin/styles'
      click_on "Delete"

      expect(current_path).to eq('/admin/styles')
      expect(space).to_not eq(false)
    end

    scenario "They attempt to delete a style that doesn't have dependencies" do
      admin = create(:user, role: 1)
      style = create(:style)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit '/admin/styles'
      click_on "Delete"

      expect(current_path).to eq('/admin/styles')
      expect(style).to eq(false)
    end

    scenario "They deactivate a user" do
      admin = create(:user, role: 1)
      spaces = create_list(:space, 3, approved: true)
      user = create(:user)
      user.spaces << spaces
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit '/admin/spaces'
      click_on "Delete"

      expect(current_path).to eq('/admin/spaces')
      expect(user.active).to eq(false)
      expect(spaces[0].active).to eq(false)
      expect(spaces[1].active).to eq(false)
      expect(spaces[2].active).to eq(false)
    end
  end
end
