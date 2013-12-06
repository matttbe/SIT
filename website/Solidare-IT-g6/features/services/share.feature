Feature: All about sharing 
  testing action when a user want to share a service

	Background:
	  Given The DB have a lot of users
	  And The database contains services

	@wip
	Scenario: Validated user can share a service from the services list
      And I am logged in
	  When I go to the services list
	  Then I should see a share link
	
	@wip 
	Scenario: Validated user can share a service from its page
	  And I am logged in
	  When I visit the page of one service
	  Then I should see a share link
	
	@wip  
	Scenario: Validated user can see share links in the bottom of the home page
	  When I log in
	  Then I should see a share link