require 'rails_helper'

RSpec.describe Planet, type: :model do
  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  context "planet not valid without validations" do
    planet = Planet.new(name: "")
    it "is not valid" do
      expect(planet).to_not be_valid
    end
  end

  context "planet not valid if not unique" do
    planet = Planet.create(name: "test")
    planet2 = Planet.create(name: planet.name)
    it "is not valid" do
      expect(planet2).to_not be_valid
    end
  end
end
