Feature: Searching Ruby on Google.com

  Scenario: Visit google.com

    Given I am on google.com

    When I'm searching with 'ruby programming language'

    Then I should find each picture and click it
