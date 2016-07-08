require 'rails_helper'

RSpec.describe Planet, type: :model do
  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  context "it can toggle active status" do
    it "toggles correctly" do
      planet = Planet.create(name: "test", active: true)
      planet.toggle_active
      expect(planet.active).to eq false
    end
  end
end
