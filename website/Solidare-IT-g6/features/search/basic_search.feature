Feature: Basic search
  testing action for basic search

    Background:
      Given I am not logged in
      And The database contains services

    Scenario: User can perform a search
      When I return to the site
      And I do a search of Livre words in Demand
      And I click on the Search button
      Then I see a service

    Scenario: User who do a search on offer with "search" show anything
      When I return to the site
      And I do a search of  search words in Offer
      And I click on the Search button
      Then I should not see my service

    Scenario: User who do a search on offer with no argument should see something
      When I return to the site
      And I do a search without any words in Demand
      And I click on the Search button
      Then I should see services

