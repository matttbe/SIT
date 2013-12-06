Feature: All about sharing 
  testing action when a user want to share a service

	Background:
	  Given The DB have a lot of users
	  And The database contains services

	
	Scenario: Validated user can share a service from the services list
      And The database contains services
      And I am logged in
	  When I click on the Search button
	  Then I should see a share link
	
	Scenario: Validated user can share a service from its page
	  And The database contains services
	  And I am logged in
	  When I visit the page of one service
	  Then I should see a share link
	