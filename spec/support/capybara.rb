# frozen_string_literal: true

Dir[Rails.root.join("spec", "feature_steps", "**", "*.rb")].sort.each { |f| require f }

require "capybara/cuprite"
require "capybara/rspec"
require "capybara-screenshot/rspec"
require "billy/capybara/rspec"

Capybara::Screenshot.prune_strategy = {keep: 20}
Capybara.default_max_wait_time = 5
Capybara.disable_animation = true

Capybara.javascript_driver = :cuprite_proxy
Capybara.register_driver(:cuprite_proxy) do |app|
  browser_options = {}.tap do |opts|
    opts["no-sandbox"] = nil if ENV["CI"]
    opts["ignore-certificate-errors"] = nil
  end
  Capybara::Cuprite::Driver.new(
    app,
    window_size: [1200, 800],
    js_errors: true,
    timeout: 10,
    process_timeout: 15,
    inspector: ENV["INSPECTOR"],
    # headless: false,
    browser_options: browser_options
  ).tap do |driver|
    driver.set_proxy(Billy.proxy.host, Billy.proxy.port)
  end
end

Capybara.asset_host = "http://localhost:3000"
