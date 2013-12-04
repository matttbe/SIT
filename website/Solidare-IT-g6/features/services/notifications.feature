Feature: All about notifications
  testing action when a user receives notifications

	Background:
	  Given The DB have a lot of users
	  And The database contains services

	Scenario: Validated user who follows a service receives a notification when the service is updated.
	  And I log in
      When I visit the notifications page
	  And The service is updated
	  Then I should see a update notification
	  
	Scenario: Validated user who follows a service receives a notification when the service is accepted.
	  And I log in
      When I visit the notifications page
	  And The service is accepted
	  Then I should see a accept notification

	Scenario: A creator receive a notification if his service is follow or unfollow
	  And I log In
	  When a user follor or unfollow my service
	  And I visit the notifications page
	  Then I should see a follow or unfollow notification
	  
	Scenario: A creator receive a notification if his service is accepted
	  And I log In
	  When a user accept my service
	  And I visit the notifications page
	  Then I should see a accept notification
	  