# Foursquare Search Interface

Search interface that finds venues from Foursquare, allowing user to mark some as "favourite", and retrieve those favourites later.

## Installation

I have included a bootstrap script which will check for dependencies and guide you through the installation process:

    ./script/bootstrap

If for some reason that doesn't work, here are the manual steps:

- make sure you have `homebrew` and `rbenv` or `rvm` installed;
- use ruby version `1.9.2` or higher (1.9.3 recommended) and make sure you have `bundler` installed (if not, run `gem install bundler`);
- start redis or install it with `brew install redis` and follow the instructions;
- install phantomjs with `brew install phantomjs` (version 1.7+ recommended);
- install the gems with `bundle install`;
- run the database migrations with `bundle exec rake db:drop db:create db:migrate`;

Assuming you have a `client_id` and `client_secret` for the [Foursquare API](https://foursquare.com/developers/apps),
add them to the proxy in `lib/foursquare_proxy.rb`. If you don't have, create
an application on the URL above with a redirect URL matching your server. Here
is an example:

    http://localhost:3000/auth/foursquare/callback

When all is installed and ready to go, run `bundle exec rails s` to start the server.

## Tests

In order to run the specs, make sure you have [phantomjs](http://phantomjs.org) installed. On OSX, you can run:

    brew install phantomjs

Then, run:

    bundle exec rake test RAILS_ENV=test
