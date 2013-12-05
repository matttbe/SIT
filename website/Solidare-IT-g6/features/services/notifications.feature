Feature: All about notifications
  testing action when a user receives notifications

	Background:
	  Given The DB have a lot of users
	  And The database contains services

	Scenario: Validated user who follows a service receives a notification when the service is updated.
	  And I am logged in
      When I visit the notifications page
	  And The service is updated
	  Then I should see a update notification
	  
	Scenario: Validated user who follows a service receives a notification when the service is accepted.
	  And I am logged in
      When I visit the notifications page
	  And The service is accepted
	  Then I should see a accept notification

	Scenario: A creator receive a notification if his service is follow or unfollow
	  And I am logged in
	  And The database contains my services
	  When a user follow my service
	  And I visit the notifications page
	  Then I should see a follow notification

	Scenario: A creator receive a notification if his service is follow or unfollow
	  And I am logged in
	  And The database contains my services
	  When a user unfollow my service
	  And I visit the notifications page
	  Then I should see a unfollow notification
	  
	Scenario: A creator receive a notification if his service is accepted
	  And I am logged in
	  And The database contains my services
	  When a user accept my service
	  And I visit the notifications page
	  Then I should see a accept notification
	  