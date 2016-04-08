require 'capybara/rspec'
require 'selenium/webdriver'
require 'pry'
require 'dropbox_sdk'
require './lib/settings'
require './lib/dropbox_client_wrapper'
require 'random_data'
require 'random_word_generator'
require 'fuubar'

Dir['./spec/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.include WaitForAjax
  config.include Helpers
  config.include Capybara::DSL

  browser = Settings.find_browser(ENV['BROWSER'])
  # clean previous screens from dropbox
  # DropboxClientWrapper.clean_folder

  # Capybara settings
  # for Browserstack
  if browser
    Capybara.register_driver :selenium do |app|

      Capybara::Selenium::Driver.new(app, {
        :browser => :remote,
        :url => Settings.get_config['browserstack'],
        :desired_capabilities => Selenium::WebDriver::Remote::Capabilities.new(browser.merge({human: ENV['BROWSER'].gsub('_', ' '), 'nativeEvents': true, 'browserstack.debug': true, 'cssSelectorsEnabled': true, 'javascriptEnabled': true, 'resolution': '2048x1536', 'browserstack.video': false, 'browserstack.selenium_version': '2.50.0' }))
      })
    end
  else
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :chrome)
    end
  end

  Capybara.current_driver    = :selenium
  Capybara.app_host          = Settings.get_config['host']
  Capybara.run_server        = false
  Capybara.default_max_wait_time = 14

  puts "═" * 77
  puts "               [Automation Testing Framework, 2016]"
  puts "═" * 77
  puts"
████████╗███████╗███████╗████████╗
╚══██╔══╝██╔════╝██╔════╝╚══██╔══╝
   ██║   █████╗  ███████╗   ██║
   ██║   ██╔══╝  ╚════██║   ██║
   ██║   ███████╗███████║   ██║
   ╚═╝   ╚══════╝╚══════╝   ╚═╝

"
  puts "═" * 77
  puts "                 [Host: #{Capybara.app_host}]"
  puts "═" * 77

  # Maxmize window
  config.before(:each, js: true) do
    @session_pool = {}
    Capybara.page.driver.browser.manage.window.maximize
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # load failed test's screen to Dropbox
  config.after(:each) do |example|
    if example.exception
      image_name = [ENV['BROWSER'], '_', example.metadata[:full_description].downcase.gsub(/[^\s\w]+/, '').gsub(' ', '_'), '.png'].join()

      page.driver.save_screenshot(image_name, :full => true)
      file = open(image_name)

      puts "uploaded #{image_name}:", DropboxClientWrapper.load_screenshot(file, image_name).inspect
      # File.delete(file)
    end
  end
end
