Feature: All about following
  testing action when a user follow/unfollow a service

	Background:
	  Given The DB have a lot of users
	  And The database contains services

	Scenario: Validated user can follow a service
      And I am logged in
	  When I visit the page of one service
	  Then I should see a follow link
	  And I can not see the unfollow link

	Scenario: Validated user can unfollow a service
      And I am logged in
	  When I visit the page of one service
	  And I click on the Follow link
	  Then I should see a unfollow link
	  And I can not see the follow link

	Scenario: A visiter can not follow or unfollow a service
   	  And I am not logged in
	  When I visit the page of one service
	  Then I can not see the follow link
	  And I can not see the unfollow link

	Scenario: A creator can not follow his own service
      And I am logged in
	  When I visit the page of my service
	  Then I can not see the follow link

	Scenario: A creator can see the followers of his own service
	  And I am logged in
	  And The database contains my services
	  When Some users follow my service
	  Then I can see the followers of my service

	Scenario: Validated user can unfollow a service from his following service page
      And I am logged in
	  And I follow a service
	  When I visit the page of the services followed
	  Then I should see a unfollow link
	  And I should see an accept link
	  And I can not see the follow link
 
   	Scenario: Validated user receives a notification when a service he follows is destroyed.
      And The database contains services
      And I follow a service
      When the service I follow is destroyed
      And I visit the page of the services followed
      Then I should not see the service anymore
      