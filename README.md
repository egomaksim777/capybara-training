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
