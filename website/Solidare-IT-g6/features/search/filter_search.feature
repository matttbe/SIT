Feature: Search with filter
  testing filter on search

    Background:
      Given I am not logged in
      And The database contains services

    Scenario: Filter with active show anything
      When I return to the site
      And I do a search of Livre words in Demand
      And I click on the Search button
      And I click on the Show only active service link
      Then I see a No result message


