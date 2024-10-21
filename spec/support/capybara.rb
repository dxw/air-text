# frozen_string_literal: true

Dir[Rails.root.join("spec", "feature_steps", "**", "*.rb")].sort.each { |f| require f }

require "capybara/cuprite"
Capybara.default_max_wait_time = 5
Capybara.disable_animation = true
Capybara.javascript_driver = :cuprite
Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(
    app,
    window_size: [1200, 800],
    js_errors: true,
    timeout: 10,
    process_timeout: 15,
    inspector: ENV["INSPECTOR"]
  )
end
Capybara.asset_host = "http://localhost:3000"
