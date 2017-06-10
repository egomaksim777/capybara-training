require './lib/settings'
require 'capybara/cucumber'
require 'pry'
require 'rspec'

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

HOST_URL = Settings.getting_config['host']
Capybara.app_host          = HOST_URL
Capybara.default_driver    = :selenium
Capybara.javascript_driver = :selenium
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

Capybara.page.driver.browser.manage.window.maximize
sleep 1
puts ''

