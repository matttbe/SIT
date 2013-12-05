Feature: All about notifications
  testing action when a user receives notifications

  Background:
    Given The DB have a lot of users
    And The database contains services

  Scenario: Validated user who follows a service receives a notification when the service is updated.
    And I follow a service
    When The service is updated
    And I visit the notifications page
    Then I should see a update notification

  Scenario: Validated user who follows a service receives a notification when the service is accepted.
    And I am logged in
    And I follow a service
    When The service is accepted
    And I visit the notifications page
    Then I should see a accept notification

  Scenario: A creator receive a notification if his service is followed
    And The database contains my services
    And a user click on the follow button of one of my service
    When I visit the notifications page
    Then I should see a follow notification

  Scenario: A creator receive a notification if his service is unfollowed
    And The database contains my services
    And a follower click on the unfollow button of one of my service
    When I visit the notifications page
    Then I should see a unfollow notification

  Scenario: A creator receive a notification if his service is accepted
    And The database contains my services
    And a user click on the accept button of one of my service
    When I visit the notifications page
    Then I should see a accept notification
