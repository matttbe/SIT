Feature: Admin backoffice
  As a registered admin of the website
  I want to do admin stuffs

  Scenario: As a regular user who is signed in, I am redirected to the homepage
    Given I am logged in
    When I go to admin page
    Then I should be on root page

  Scenario: If I am not signed in, I am redirected to login
    Given I exist as a user
    And I am not logged in
    When I go to admin page
    Then I see a return message on sign in page

  Scenario: As an admin user, I can see the admin dashboard
    Given I exist as an admin user
    And I am not logged in
    When I sign in with valid credentials for admin user
    And I go to admin page
    Then I should see the Dashboard

  Scenario: User signs out
    Given I exist as an admin user
    And I am not logged in
    When I sign in with valid credentials for admin user
    And I go to admin page
    And I sign out
    Then I see a Signed out successfully message

  Scenario: As an admin user, I can see non validated user
    Given I exist as an admin user
    And I am not logged in
    And The DB have a lot of users
    When I sign in with valid credentials for admin user
    And I go to admin page
    Then I should see non validated user

  Scenario: As an admin user, I can validate a non validated user
    Given I exist as an admin user
    And I am not logged in
    And The DB have a lot of users
    When I sign in with valid credentials for admin user
    And I go to admin page
    Then I should validated a non validated user
    And I din't see it again on the dashboard
