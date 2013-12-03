Feature: All about notifications
  testing action when a user receives notifications

	Background:
	  Given The DB have a lot of users
	  And The database contains services

	Scenario: Validated user who follows a service receives a notification when the service is updated.
	  And I log in
      When I follow a service
	  And The service is updated
	  Then I should see a notification
	  
	Scenario: Validated user who follows a finished service should not see this service anymore
	  And I log in
	  When I follow a service
	  And The service is finished
	  Then I can not see the service anymore
