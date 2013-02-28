require 'csv'

class Venue < ActiveRecord::Base
  attr_accessible :venue_id, :canonical_url, :name, :categories, :address, :city, :country, :distance
  has_many :favourites
  has_many :users, through: :favourites

  self.primary_key = :venue_id

  def self.from_search_venue(hash_object)
    venue = Venue.new
    venue.venue_id = hash_object.id
    venue.canonical_url = hash_object.canonicalUrl
    venue.name = hash_object.name
    venue.categories = hash_object.categories.map{|category| category.name }.join(', ')
    venue.address = hash_object.location.address
    venue.city = hash_object.location.city
    venue.country = hash_object.location.country
    venue.distance = hash_object.location.distance
    venue
  end

  def self.clear_cached_venues
    $redis.del 'venues'
  end

  def self.cache_venue(venue)
    $redis.hmset 'venues', venue.venue_id, venue.to_json
  end

  def self.get_venue(id)
    JSON.parse($redis.hget 'venues', id)
  end

  def self.find_or_create(id)
    venue = Venue.find_by_venue_id(id)
    return venue unless venue.nil?
    venue = Venue.new(Venue.get_venue(id))
    venue.save
    venue
  end

  def self.to_csv(venue_list)
    columns = Venue.attribute_names
    CSV.generate do |csv_data|
      csv_data << columns
      venue_list.each do |venue|
        csv_data << venue.attributes.values_at(*columns)
      end
    end
  end

end
