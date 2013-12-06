Feature: All about profiles
  testing action when a user want to see profiles

  Background:
    Given The DB have a lot of users
    And The database contains services

  Scenario: Validated user can see the details of his own profile.
    And I am logged in
    When I visit my profil
    Then I can see all of my personnal informations

  Scenario: Validated user can see the details of the profiles of this followers.
    And I am logged in
    And The database contains my services
    When Some users follow my service
    Then I can see the profiles of my followers
  
  Scenario: A visiter can not follow or unfollow a service
    And I am not logged in
    When I visit the profil of a user
	Then I can not see his personal informations
    