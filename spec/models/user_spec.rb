require 'spec_helper'

describe User do

  it "has a valid factory" do
    expect(create(:user)).to be_valid
  end

  context "existence of attributes" do
    it "is valid with an email and password" do
      expect(build(:user)).to be_valid
    end
    it "is invalid without an email" do
      user = build(:user, email: nil)
      expect(user).to have(2).errors_on(:email)
    end
    it "is invalide without a username" do
      user = build(:user, username: nil)
      expect(user).to have(1).errors_on(:username)
    end
    it "is invalid without password" do
      user = build(:user, password: nil)
      expect(user).to have(3).errors_on(:password)
    end
  end

  context "password requirements" do
    it "is invalid with password less than 8 characters" do
      user = build(:user, password: "nope")
      expect(user).to have(2).errors_on(:password)
    end
  end

  context "email requirements" do
    it "is invalid with a duplicate email address" do
      create(:user, email: "test@test.com") # This user persists in the db
      user = build(:user, email: "test@test.com")
      expect(user).to have(2).errors_on(:email)
    end
  end

  context "just got a question correct" do
    it "increases the elo correctly" do
      user = build(:user, elo: 1155)
      user.update_elo(1242, true)
      expect(user.elo).to eq(1175)
    end
  end

  context "just got a question wrong" do
    it "decreases the elo correctly" do
      user = build(:user, elo: 1242)
      user.update_elo(1155, false)
      expect(user.elo).to eq(1222)
    end
  end

end