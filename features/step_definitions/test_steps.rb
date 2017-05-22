Given(/^I am on google.com$/) do
  visit '/'
end

When(/^I\'m searching with 'kitty'$/) do
  fill_in 'q', with: 'kitty'
  sleep 1
  find('[role="option"]', text: 'kitty', match: :first).click
  sleep 1
end

Then(/^I should find each picture and click it$/) do
  find('#uid_0').click
  sleep 1

  begin
    (20..24).each { |el| all('a')[el].click }
  rescue Selenium::WebDriver::Error::StaleElementReferenceError
    puts 'StaleElementReferenceError occured. Retrying...'
    retry
  end
end

