require 'spec_helper'

describe VenuesHelper do
  describe ".favourite_link" do

    describe "given no current user" do
      context "given a venue already favorited" do
        it "should return an empty string" do
          User.any_instance.should_not_receive(:has_favourite_venue?)
          helper.favourite_link(nil, "some_id").should eq("<p>?</p>")
        end
      end
    end

    describe "given there is a current user" do

      let(:current_user) { FactoryGirl.create(:user) }

      context "given a venue already favorited" do
        it "should generate a link with a full start" do
          current_user.should_receive(:has_favourite_venue?).and_return(true)
          helper.favourite_link(current_user, "some_id").should eq("<a href=\"#\" class=\"favourite\" data-id=\"some_id\"><i class=\"icon-star\"></i></a>")
        end
      end

      context "given a new venue not yet favorited" do
        it "should generate a link with an empty start" do
          current_user.should_receive(:has_favourite_venue?).and_return(false)
          helper.favourite_link(current_user, "some_id").should eq("<a href=\"#\" class=\"favourite\" data-id=\"some_id\"><i class=\"icon-star-empty\"></i></a>")
        end
      end
    end

  end
end
