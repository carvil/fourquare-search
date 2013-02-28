require 'spec_helper'

describe User do

  let(:user) { FactoryGirl.build(:user) }
  let(:venue) { FactoryGirl.create(:venue) }
  let(:auth) {{
      "provider" => user.provider,
      "uid" => user.uid,
      "info" => {
        "email" => user.email,
        "first_name" => user.first_name,
        "last_name" => user.last_name}
    }}

  describe ".from_omniauth" do
    context "given there are no users in the database" do
      it "should create the user from the params" do
        User.count.should be(0)
        User.from_omniauth(auth)
        User.count.should be(1)
        User.first.first_name.should eq(user.first_name)
        User.first.last_name.should eq(user.last_name)
        User.first.email.should eq(user.email)
      end
    end

    context "given the user exists in the database" do
      it "should return the existing record" do
        user.save!
        User.count.should be(1)
        User.from_omniauth(auth)
        User.count.should be(1)
      end
    end
  end

  describe ".create_from_omniauth" do
    context "given an auth hash containing user data" do
      it "should create the user" do
        User.count.should be(0)
        User.create_from_omniauth(auth)
        User.count.should be(1)
        User.first.first_name.should eq(user.first_name)
        User.first.last_name.should eq(user.last_name)
        User.first.email.should eq(user.email)
      end
    end
  end

  describe "#has_favourite_venue" do
   context "given a user without favourites" do
      it "should return false" do
        user.has_favourite_venue?('some_venue_id').should eq(false)
      end
   end

   context "given a user with favourites" do
      before :each do
        user.venues << venue
        user.save
      end

      it "should return true" do
        user.has_favourite_venue?(venue.venue_id).should eq(true)
      end
   end
  end

  describe "#toggle_favourite" do
    context "given a user without favourites" do
      it "should add the venue to the user's favourites" do
        user.favourites.should eq([])
        user.venues.should eq([])
        user.toggle_favourite(venue).should be_true
        user.venues.should eq([venue])
        user.favourites.should_not eq([])
      end
    end
  end
end
