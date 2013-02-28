class VenuesController < ApplicationController

  respond_to :html, :json, :js

  def index
  end

  def search
    term = params[:search]
    @venues = []
    Venue.clear_cached_venues
    $foursquare.search_venues(term).each do |search_venue|
      venue = Venue.from_search_venue(search_venue)
      Venue.cache_venue(venue)
      @venues << venue
    end
  end

  def favourite
    if current_user
      venue = Venue.find_or_create(params[:venue_id])
      favourite = current_user.toggle_favourite(venue)
      render json: { favourite: favourite }
    else
      head 401
    end
  end
end
