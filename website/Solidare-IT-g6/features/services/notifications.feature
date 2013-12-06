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

  Scenario: Validated user receives a notification when someone post a message on his group
    And the database contains groups
  	And I am logged in
  	And I am a member of a group  	  
  	When someone post a message on the group
  	And I visit the notifications page
  	Then I should see a post notification
	
  Scenario: Validated user receives a notification when someone join his group
    And the database contains groups
  	And I am logged in
  	And I am a member of a group  	  
  	When someone join the group
  	And I visit the notifications page
  	Then I should see a join notification
  	
  Scenario: A creator receive only one notification when the same user follow and unfollow the same service multiple times
    And The database contains my services
    And the same user click on the follow or unfollow button of one of my service more than once
    When I visit the notifications page
    Then I should see only one follow notification
