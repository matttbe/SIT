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
      When I click on the Add a service link
      And I fill the service form
      And I click on the Create service button
      Then I see adding service message

    Scenario: Validated user create a service with no title
      And I am logged in
      When I click on the Add a service link
      And I fill the service form
      And I fill blank the service_title fill in the service form
      And I click on the Create service button
      Then I should see a missing Title message

    Scenario: Validated user create a service with no description
      And I am logged in
      When I click on the Add a service link
      And I fill the service form
      And I fill blank the service_description fill in the service form
      And I click on the Create service button
      Then I should see a missing Description message

    Scenario: Validated user create a service with a date end before date start
      And I am logged in
      When I click on the Add a service link
      And I fill the service form
      And I fill a wrong date for the end
      And I click on the Create service button
      Then I should see a date problem message

    Scenario: Validated user can see all his services
      And I am logged in
      And The database contains my services
      When I click on the See my services link
      Then I should see my services

    Scenario: Validated user with no services can see all services
      And I am logged in
      When I click on the See my services link
      Then I should see no services



