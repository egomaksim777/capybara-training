## Shortly
This application is using for testing features of FW application.
It uses Capybara with Selenium driver.

## Installation
Required ruby version: **>2.2.1**

```sh
cp config/config.yml.example config/config.yml
Replace USERNAME and ACCESS_KEY with yours from Browserstack https://www.browserstack.com/accounts/automate
Replace ACCESS_TOKEN with yours from Dropbox ( https://www.dropbox.com/developers/apps => Create App => Dropbox API app => Yes => Create app => Generate Token )
bundle install
```

## Start testing
If you run rspec without BROWSER environment variable, it will run local default browser(Chrome).
```sh
bundle exec rspec
```

To run the browser from file **config/browsers.yml** on Browserstack, you have to run rspec with BROWSER envrironment variable. Its value should be the name of browser in the list of browsers in the file. Example:
```sh
BROWSER=ie7_windows_xp bundle exec rspec
See the test process here https://www.browserstack.com/automate
See screenshots for failed tests here  https://www.dropbox.com/home/Apps/
```

## Adding new browsers
To add a new browser for testing you have to put it in **config/browsers.yml**.
Example of browser:

```yml
chrome39_windows_7:
  os: Windows
  os_version: 7
  browser: Chrome
  browser_version: 39
```
Another examples you can find in file.

# quick help
# http://cheatrags.com/capybara

## Setting up Ruby and Git on Windows
I. Install Ruby
1. http://rubyinstaller.org/
2. Download and install Ruby 2.2.4, check 'Add Ruby executables to you PATH'.
3. Download and extract to 'path_to_ruby/DevKit/  ----> C:\Ruby22\DevKit\  ) DEVELOPMENT KIT For use with Ruby 2.0 and above (32bits version only): DevKit-mingw64-32-4.7.2-20130224-1151-sfx.exe
4. Run cmd.
5. cd C:\Ruby22\DevKit\
6. ruby dk.rb init
7. ruby dk.rb review
8. ruby dk.rb install
9. https://sites.google.com/a/chromium.org/chromedriver/downloads -- Download the ChromeDriver and put it here: C:\Ruby22\bin\

II. Install GIT
1. https://git-scm.com/download/win -- download and install
2. Go to https://github.com/egomaksim777/capybara-training

III. Setup Project
1. Start Git Bash.
2. mkdir c:/Projects/ -- put here you project
3. cd c:/Projects/capybara-training/
4. gem install bundler
5. bundle install
6. bundle exec rspec
