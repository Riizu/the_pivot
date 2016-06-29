require 'rails_helper'

RSpec.describe Space, type: :model do
  context "validations, presence" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:foot) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:style_id) }
    it { should validate_presence_of(:planet_id) }
  end

  context "validations, uniqueness" do
    it { should validate_uniqueness_of(:name) }
  end

  scenario "status returns available when not retired" do
    space = create(:space)
    expect(space.status).to eq("#{space.name} is currently available for purchase")
  end

  scenario "status returns retired when retired" do
    space = Space.new(name: "test", style_id: 1, foot: "left", planet_id: 1, price: 5.00, retired: true)
    expect(space.status).to eq("#{space.name.capitalize} is retired")
  end
end
