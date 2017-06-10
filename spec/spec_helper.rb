require 'airborne'
require 'capybara/rspec'
require 'dropbox_sdk'
require 'faker'
require 'fuubar'
require 'pry'
require 'random_data'
require 'random_word_generator'
require 'selenium/webdriver'
require './lib/dropbox_client_wrapper'
require './lib/settings'

Dir['./spec/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
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
        browser: :remote,
        url: Settings.getting_config['browserstack'],
        desired_capabilities: Selenium::WebDriver::Remote::Capabilities.new(browser.merge({ human: ENV['BROWSER'].tr('_', ' '), 'nativeEvents': true, 'browserstack.debug': true, 'cssSelectorsEnabled': true, 'javascriptEnabled': true, 'resolution': '2048x1536', 'browserstack.video': false, 'browserstack.selenium_version': '2.50.0' }))
      })
    end
  else
    Capybara.register_driver :selenium do |app|
      client = Selenium::WebDriver::Remote::Http::Default.new
      client.timeout = 120
      Capybara::Selenium::Driver.new(app, browser: :chrome)
    end
  end

  HOST_URL = Settings.getting_config['host']

  Capybara.current_driver    = :selenium
  Capybara.app_host          = HOST_URL
  Capybara.run_server        = false
  Capybara.default_max_wait_time = 7

  dev_name     = "© #{Time.now.year} Maks Karakusha"
  github       = 'https://github.com/egomaksim777'
  host         = "Host: #{HOST_URL}"
  title        = "[Automation Testing Framework, #{Time.now.year}]"
  symbol_part1 = '████████╗███████╗███████╗████████╗'
  symbol_part2 = '╚══██╔══╝██╔════╝██╔════╝╚══██╔══╝'
  symbol_part3 = '   ██║   █████╗  ███████╗   ██║   '
  symbol_part4 = '   ██║   ██╔══╝  ╚════██║   ██║   '
  symbol_part5 = '   ██║   ███████╗███████║   ██║   '
  symbol_part6 = '   ╚═╝   ╚══════╝╚══════╝   ╚═╝   '
  line         = [dev_name, github, host, symbol_part1, title].max_by(&:length).length + 4
  draw_a_line  = '═' * line
  # Draw a line
  puts draw_a_line
  # Puts a Title
  puts title.center(line)
  # Puts a Host
  puts host.center(line)
  # Draw a line
  puts draw_a_line
  # Puts TEST
  (1..6).each { |id| eval("puts symbol_part#{id}.center(line)") }
  # Draw a line
  puts draw_a_line
  # Puts a Github
  puts github.center(line)
  # Puts a test developer name
  puts dev_name.center(line)
  # Draw a line
  puts draw_a_line

  config.before(:each, js: true) do
    @session_pool = {}
    Capybara.page.driver.browser.manage.window.maximize
    sleep 1
    puts ''
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # load failed test's screen to Dropbox
  config.after(:each) do |example|
    if example.exception
      # Make screenshot
      image_name = [
        Time.now.strftime('%F___%H-%M-%S'),
        '_',
        ENV['BROWSER'],
        '_',
        example.metadata[:full_description].downcase.gsub(/[^\s\w]+/, '').tr(' ', '_'),
        '.png'
      ].join

      page.driver.save_screenshot(image_name, full: true)
      puts 'Screenshot is saved'
      # Upload screenshot to the DropBox
      file = open(image_name)
      puts "Screenshot is uploaded to DropBox as #{image_name}:", DropboxClientWrapper.upload_file(file, image_name).inspect

      # Write browser console output to the log file
      log_name = [
        'log_',
        Time.now.strftime('%F___%H-%M-%S'),
        '_',
        ENV['BROWSER'],
        '_',
        example.metadata[:full_description].downcase.gsub(/[^\s\w]+/, '').tr(' ', '_'),
        '.log'
      ].join

      log_file = File.new(log_name, 'w')
      log_file.puts page.driver.browser.manage.logs.get(:browser)
      log_file.close
      puts 'Log is saved'
      # Upload log to the DropBox
      file = open(log_file)
      puts "Log uploaded to DropBox as #{log_name}:", DropboxClientWrapper.upload_file(file, log_name).inspect
    end
  end
end
