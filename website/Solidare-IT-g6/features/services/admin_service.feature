Feature: Service aprt in the admin section
  testing action when a admin see the service part of his dashboard

    Background:
      Given The DB have a lot of users
      And The database contains services

    Scenario: As an admin user, I can see all services
      And I exist as an admin user
      And I am not logged in
      When I sign in with valid credentials for admin user
      And I click on the Services link
      Then I should see services
