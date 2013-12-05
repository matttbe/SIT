Feature: Add, edit and destroy a Group
  testing action when a registered user add, edit or destroy a group

    Background:
      Given The DB have a lot of users
      And The database contains services

    Scenario: Validated user can create a group
      And I am logged in
      When I return to the site
      Then I see the create a group button

    @wip
    Scenario: Validated user create a group
      And I am logged in
      When I return to the site
      And I click on the Create a group link
      And I fill the group form
      And I click on the Save Group button
      Then I see a Group was successfully created. message
