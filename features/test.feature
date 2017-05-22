Feature: Searching Kitties on Google.com

  Scenario: Visit google.com

    Given I am on google.com

    When I'm searching with 'kitty'

    Then I should find each picture and click it
