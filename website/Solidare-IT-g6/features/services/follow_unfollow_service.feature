Feature: All about following
  testing action when a user follow/unfollow a service

    Background:
      Given The DB have a lot of users
      And The database contains services

    Scenario: Validated user can follow a service
      And I log in
      When I visit the page of one service
      Then I should see a follow link
      And I can not see the unfollow link   
      
   Scenario: Validated user can unfollow a service
      And I log in
      When I visit the page of one service
      And I click on the Follow button
      Then I should see a unfollow link
      And I can not see the follow link   
      
    Scenario: A visiter can not follow or unfollow a service
      And I am not logged in
      When I visit the page of one service
      Then I can not see the follow link
      And I can not see the unfollow link   
      
   Scenario: A creater can not follow his own service
      And I log in
      When I visit the page of my service
      Then I can not see the follow link   
      