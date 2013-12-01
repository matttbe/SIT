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

      