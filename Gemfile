# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby "3.4.5"

gem "active_link_to", "~> 1.0" # Active links with CSS classes
gem "bootsnap", ">= 1.1.0", require: false
gem "dartsass-rails", "~> 0.5.1"
gem "high_voltage"
gem "jbuilder", "~> 2.11"
gem "lograge", "~> 0.12"
gem "pg"
gem "pry-rails"
gem "pry-byebug"
gem "puma", "~> 6.4"
gem "rollbar"
gem "rails", "~> 7.2"
gem "sprockets-rails", "~> 3.5"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
gem "terser"
gem "httparty"
gem "view_component"
gem "seed-fu"
gem "factory_bot_rails"
gem "faker"
gem "wicked" # for multi-step forms

group :development do
  gem "better_errors"
  gem "listen", ">= 3.0.5", "< 3.10"
  gem "rails_layout"
  gem "spring"
  gem "spring-commands-rspec"
  gem "web-console", ">= 3.3.0"
  gem "htmlbeautifier"
end

group :development, :test do
  gem "axe-core-capybara" # Accessibility testing
  gem "axe-core-rspec" # Accessibility testing
  gem "binding_of_caller"
  gem "brakeman"
  gem "bullet"
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "dotenv"
  gem "rspec-rails"
  gem "rails-controller-testing"
  gem "standard"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "capybara-screenshot"
  gem "launchy"
  gem "puffing-billy", "~> 4.0"
  gem "selenium-webdriver"
  gem "simplecov"
  gem "shoulda-matchers", "~> 6.0"
  gem "table_print", "~> 1.5"
  gem "climate_control"
  gem "webmock"
end

gem "cssbundling-rails", "~> 1.4"
gem "stimulus-rails"
gem "jsbundling-rails", "~> 1.3"
