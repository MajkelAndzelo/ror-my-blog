require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "requires an email address" do
      user = User.new(password: "password")
      expect(user).not_to be_valid
    end

    it "requires a valid email address" do
      user = User.new(email: "invalid-email", password: "password")
      expect(user).not_to be_valid
    end

    it "requires a password" do
      user = User.new(email: "test@example.com")
      expect(user).not_to be_valid
    end
  end
end
