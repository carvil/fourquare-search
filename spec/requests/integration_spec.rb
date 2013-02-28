require "spec_helper"

describe "Foursquare search" do

  before :each do
    VCR.use_cassette('search_venues', record: :new_episodes) do
      @venues = $foursquare.search_venues("la bouche")
    end
    $foursquare.stub!(:search_venues).and_return(@venues)
  end

  context "home page", js: true do

    it "contains the expected elements and it is possible to search" do
      visit '/'
      page.should have_content('Search for venues on foursquare')
      page.should have_link "Sign in with Foursquare"
      page.should have_button "Search"
      page.should have_css "input[name='search']"
      page.should_not have_link "Favourites"
      within("#search-form") do
        fill_in 'search-input', with: "la bouche"
      end
      page.has_css?("#search-results > div.row", :count => 0)
      click_button "Search"
      sleep 2
      page.has_css?("#search-results > div.row", :count => 20)
    end
  end

end
