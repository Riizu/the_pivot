require 'rails_helper'
RSpec.describe User, type: :model do
  context "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end

  context "user not valid without validations" do
    it "is not valid" do
      user = User.new(username: "", password: "test")
      expect(user).to_not be_valid
    end
  end

  context "user not valid if username not unique" do
    it "is not valid" do
      user1 = User.create(username: "test", first_name: "first", last_name: "last", password: "password", email: "test1@test.com")
      user2 = User.new(username: "test", first_name: "first", last_name: "last", password: "password", email: "test2@test.com")
      expect(user2).to_not be_valid
    end
  end
end
