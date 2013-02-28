FactoryGirl.define do
  factory :venue do
    venue_id "abc123"
    canonical_url "http://some.url"
    name "le restaurant"
    categories "Restaurant, Bar"
    address "1 Street"
    city "London"
    country "UK"
    distance "500"
  end
end
