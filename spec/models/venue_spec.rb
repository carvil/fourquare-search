require 'spec_helper'

describe Venue do

  before :each do
    $redis.del 'venues'
    Venue.delete_all
  end

  let(:venue) { FactoryGirl.create(:venue) }
  let(:unsaved_venue) { FactoryGirl.build(:venue) }

  describe ".from_search_venue" do

    let(:result) {$foursquare.search_venues('Dove').first}

    context "given an object from the foursquare API" do
      it "should build a venue object without saving it" do
        VCR.use_cassette('venue_create', record: :new_episodes) do
          Venue.count.should eq(0)
          venue = Venue.from_search_venue(result)
          venue.class.should eq(Venue)
          venue.as_json.should eq({
            "address"=>"19 Upper Mall",
            "canonical_url"=>"https://foursquare.com/v/the-dove/4ac518bdf964a520c8a220e3",
            "categories"=>"Pub",
            "city"=>"Hammersmith",
            "country"=>"United Kingdom",
            "distance"=>3397,
            "name"=>"The Dove",
            "venue_id"=>"4ac518bdf964a520c8a220e3"})
          Venue.count.should eq(0)
        end
      end
    end
  end

  describe ".cache_venues" do
    context "given a venue to cache" do

      before :each do
        $redis.del 'venues'
      end

      it "should store it in redis" do
        $redis.hkeys('venues').should eq([])
        Venue.cache_venue(venue)
        $redis.hkeys('venues').should eq([venue.id])
      end
    end
  end

  describe ".clear_cached_venues" do
    context "given a venue in the cache" do

      before :each do
        $redis.hmset 'venues', venue.venue_id, venue
      end

      it "should clear the venues" do
        $redis.hkeys('venues').should eq([venue.id])
        Venue.clear_cached_venues
        $redis.hkeys('venues').should eq([])
      end
    end
  end

  describe ".get_venue" do
    context "given a venue in the cache" do

      before :each do
        $redis.hmset 'venues', venue.venue_id, venue.to_json
      end

      it "should return the object" do
        $redis.hkeys('venues').should eq([venue.id])
        Venue.get_venue(venue.id).should eq({
          "address"=>"1 Street",
          "canonical_url"=>"http://some.url",
          "categories"=>"Restaurant, Bar",
          "city"=>"London",
          "country"=>"UK",
          "distance"=>"500",
          "name"=>"le restaurant",
          "venue_id"=>"abc123"})
      end
    end
  end

  describe ".find_or_create" do
    context "given there is a venue in the db" do
      it "should return it" do
        Venue.should_not_receive(:get_venue)
        Venue.find_or_create(venue.venue_id).should eq(venue)
      end
    end

    context "given there is a venue in redis" do
      it "should create it in the db and return th eobject" do
        Venue.cache_venue(unsaved_venue)
        Venue.count.should eq(0)
        Venue.find_or_create(unsaved_venue.venue_id).should eq(unsaved_venue)
        Venue.count.should eq(1)
      end
    end
  end

  describe ".to_csv" do
    context "given a list of venues" do
      it "should generate the CSV data" do
        Venue.to_csv([venue]).should eq("venue_id,canonical_url,name,categories,address,city,country,distance\nabc123,http://some.url,le restaurant,\"Restaurant, Bar\",1 Street,London,UK,500\n")
      end
    end
  end
end
