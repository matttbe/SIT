Feature: Addresses of user
  everything about addresses and users

    Background:
      Given The DB have a lot of users
      And The database contains services

    Scenario: A non registered user can not manage his addresses
      And I do not exist as a user
      When I return to the site 
      Then I can not see the manage my adresses link

    Scenario: A registered user can manage his addresses
      And I am logged in
      When I return to the site 
      Then I can see the manage my adresses link

    Scenario: A registered user can add a address
      And I am logged in
      When I return to the site 
      And I click on the Manage my addresses link
      Then I can see the add adresses link
