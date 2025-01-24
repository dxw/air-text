# frozen_string_literal: true

Dir[Rails.root.join("spec", "feature_steps", "**", "*.rb")].sort.each { |f| require f }

require "capybara/rspec"
require "capybara-screenshot/rspec"
require "billy/capybara/rspec"

Capybara::Screenshot.prune_strategy = {keep: 20}
Capybara.default_max_wait_time = 5
Capybara.disable_animation = true
Capybara.asset_host = "http://localhost:3000"

def browser_options
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument("--headless=new")
  options.add_argument("--enable-features=NetworkService,NetworkServiceInProcess")
  options.add_argument("--ignore-certificate-errors")
  options.add_argument("--proxy-server=#{Billy.proxy.host}:#{Billy.proxy.port}")
  options.add_argument("--disable-gpu") if Gem.win_platform?
  options.add_argument("--no-sandbox") if ENV["CI"]
  options.add_argument("--log-level=3")
  options.add_argument("--window-size=1200,2000")
  options.add_argument("--disable-dev-shm-usage")
  options
end

def driver(app)
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: browser_options,
    clear_local_storage: true,
    clear_session_storage: true
  )
end

Capybara.register_driver :chrome do |app|
  driver(app)
end
Capybara.javascript_driver = :chrome
