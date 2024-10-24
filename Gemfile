# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby "3.3.5"

gem "bootsnap", ">= 1.1.0", require: false
gem "bootstrap", ">= 4.3.1"
gem "high_voltage"
gem "jbuilder", "~> 2.11"
gem "jquery-rails"
gem "lograge", "~> 0.12"
gem "pg"
gem "pry-rails"
gem "pry-byebug"
gem "puma", "~> 6.4"
gem "rollbar"
gem "rails", "~> 7.2"
gem "sass-rails", "~> 6.0"
gem "turbolinks", "~> 5" # we'll remove this once we've migrated to ESbuilt assets
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
gem "terser"
gem "govuk-components"
gem "httparty"
gem "view_component"

group :development do
  gem "better_errors"
  gem "listen", ">= 3.0.5", "< 3.10"
  gem "rails_layout"
  gem "spring"
  gem "spring-commands-rspec"
  gem "web-console", ">= 3.3.0"
  gem "htmlbeautifier"
  gem "solargraph"
end

group :development, :test do
  gem "brakeman"
  gem "bullet"
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails"
  gem "rails-controller-testing"
  gem "standard"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "cuprite"
  gem "database_cleaner"
  gem "launchy"
  gem "selenium-webdriver"
  gem "simplecov"
  gem "climate_control"
  gem "webmock"
end

gem "cssbundling-rails", "~> 1.4"
gem "stimulus-rails"
gem "jsbundling-rails", "~> 1.3"
