Feature: Add and edit a Service
  testing action when a registered user add or edit his service

    Background:
      Given The database contains services

    Scenario: Validated user can create a service
      And I am logged in
      When I return to the site
      Then I see the add service button

    Scenario: Validated user create a service
      And I am logged in
      When I click on the add service link
      And I fill the service form
      Then I see adding service message
