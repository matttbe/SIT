Feature: Accept a Service
  testing action when a registered user accept a service

    Background:
      Given The database contains services

    Scenario: Validated user visiting a not own service can accept it
      And I am logged in
      When I visit the page of one service
      Then I should see the accept link 
