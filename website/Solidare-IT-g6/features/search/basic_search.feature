Feature: Basic search
  testing action for basic search

    Background:
      Given I am not logged in
      And The database contains services

    Scenario: User not signed up can show all services
      When I return to the site
      And I do a search of Livre words
      And I click on the Search button
      Then I see a service

