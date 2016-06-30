require 'rails_helper'

RSpec.describe Space, type: :model do
  context "validations, presence" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:style_id) }
    it { should validate_presence_of(:planet_id) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:occupancy) }
  end

  context "validations, uniqueness" do
    it { should validate_uniqueness_of(:name) }
  end

  scenario "returns approved when space is approved" do
    space = create(:space, approved: true)
    expect(space.approved).to eq(true)
  end

  scenario "available returns false when a space is not available" do
    space = create(:space)

    expect(space.approved).to eq(false)
  end
end
