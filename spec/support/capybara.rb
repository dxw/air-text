# frozen_string_literal: true

Dir[Rails.root.join("spec", "feature_steps", "**", "*.rb")].sort.each { |f| require f }

Capybara.asset_host = "http://localhost:3000"
