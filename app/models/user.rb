class User < ActiveRecord::Base
  attr_accessible :first_name, :provider, :uid, :last_name, :email
  has_many :favourites
  has_many :venues, through: :favourites

  def self.from_omniauth(auth)
    where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.first_name = auth["info"]["first_name"]
      user.last_name = auth["info"]["last_name"]
      user.email = auth["info"]["email"]
    end
  end

  def has_favourite_venue?(venue_id)
    !favourites.where(venue_id: venue_id).empty?
  end

  def toggle_favourite(venue)
    if has_favourite_venue?(venue.venue_id)
      favourites.find_by_venue_id(venue.venue_id).destroy
      return false
    else
      venues << venue
      return true
    end
  end

end
