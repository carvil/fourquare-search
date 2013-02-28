class Favourite < ActiveRecord::Base
  attr_accessible :user_id, :venue_id
  belongs_to :venue, dependent: :destroy
  belongs_to :user
end
