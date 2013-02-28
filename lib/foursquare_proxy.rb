require 'foursquare2'

class FoursquareProxy
  CLIENT_ID = 'YOUR_CLIENT_ID'
  CLIENT_SECRET = 'YOUR_CLIENT_SECRET'
  API_VERSION = '20130101'

  LAT = 0 # SELECT LATITUDE
  LONG = 0 # SELECT LONGITUDE

  def initialize
    @client = Foursquare2::Client.new(:client_id => CLIENT_ID, :client_secret => CLIENT_SECRET, :version => API_VERSION)
  end

  def search_venues query
    @client.search_venues(:ll => "#{LAT},#{LONG}", :query => query).groups.first.items
  end

end
