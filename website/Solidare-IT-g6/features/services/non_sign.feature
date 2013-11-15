Feature: Service for non signed User
  testing action on service with a non signed user

    Background:
      Given I am not logged in
      And The database contains services

    Scenario: User not signed up can show all services
      When I return to the site
      And I go to the services list
      Then I see a service

    Scenario: User not signed up can not add a service
      When I return to the site
      And I go to the service_add page
      Then I see a return message on sign in page


