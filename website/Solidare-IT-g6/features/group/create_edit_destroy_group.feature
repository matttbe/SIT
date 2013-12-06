Feature: Add, edit and destroy a Group
  testing action when a registered user add, edit or destroy a group

    Background:
      Given The DB have a lot of users
      And The database contains services

    Scenario: Validated user can create a group
      And I am logged in
      When I return to the site
      Then I see the create a group button

    Scenario: Validated user create a group
      And I am logged in
      When I return to the site
      And I click on the Create a group link
      And I fill the group form
      And I click on the Save Group button
      Then I see a Group was successfully created. message
      
	Scenario: A visiter can not see the members of a group neither the delete button
   	  And the database contains groups
   	  And I am not logged in
	  When I visit the page of a group
	  Then I can not see the members
	  And I can not see the delete link
	  
	Scenario: Validated user can see the members of a group and the delete button
   	  And the database contains groups
   	  And I am logged in
   	  And I am a member of a group
	  When I visit the page of a group
	  Then I should see the members
	  And I should see the delete link
	  
	Scenario: Validated user can see the members of a group but not the delete button
   	  And the database contains groups
   	  And I am logged in
	  When I visit the page of a group
	  Then I should see the members
	  And I can not see the delete link
	  
	Scenario: Validated user and member of a group can quit a group
	  And the database contains groups
	  And I am logged in
	  And I am a member of a group
	  When I visit the page of a group
	  Then I should see a leave button
 
    Scenario: Validated user can join a group from the group's page
      And the database contains groups
      And I am logged in
      When I visit the page of a group
      Then I should see a join button
    @wip  
    Scenario: Validated user can join a group from the global page of groups
      And the database contains groups
      And I am logged in
      When I check groups
      Then I should see a join button
    
      