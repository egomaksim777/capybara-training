require './lib/settings'
require 'capybara/cucumber'
require 'pry'
require 'rspec'

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.app_host          = Settings.getting_config['host']
Capybara.default_driver    = :selenium
Capybara.javascript_driver = :selenium
Capybara.default_max_wait_time = 7
