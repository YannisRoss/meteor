# MeteoR

MeteoR(ails) is a Ruby on Rails API that interfaces with [Open-Meteo's weather forecast API](open-meteo.com). It lets users create accounts and retrieve weather forecast data by providing a location's latitude and longitude. Users _**have to**_ provide a resume file in order to use the weather forecast API. Users can also save weather data on the database, and retrieve or delete it later.

## Running the app
Run the server with `rails s`, don't forget to `rails db:migrate`. MeteoR uses postgres and the [pg gem](https://github.com/ged/ruby-pg) for its database.

## API Endpoints
A list of the API endpoints can be found under `/api-docs/index.html`, using [OpenAPI 3.0 Swagger](https://swagger.io/) and [rswag](https://github.com/rswag/rswag). There are example values and requests that you can try with the `Try it out` button.

## Authentication
Authentication is handled by generating user sessions and signed IDs that expire after 5 hours. The groundwork for the auth setup was built with the [Authentication Zero gem](https://github.com/lazaronixon/authentication-zero).

## Testing
MeteoR uses [RSpec](https://github.com/rspec/rspec-rails) for testing. Run `bundle exec rspec` to run the full tests collection, or `bundle exec rspec your/test/directory` to run individual tests.
