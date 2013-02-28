# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    provider "foursquare"
    uid "some_random_uid"
    first_name "Carlos"
    last_name "Vilhena"
    email "carlosvilhena@gmail.com"
  end
end
