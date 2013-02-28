class FavouritesController < ApplicationController

  respond_to :html, :csv

  def index
    @venues = User.find(params[:user_id]).venues
    respond_to do |format|
      format.html
      format.csv {
        send_data Venue.to_csv(@venues)
      }
    end
  end
end
