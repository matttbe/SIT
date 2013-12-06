Feature: Add, edit and destroy a Organisation
  testing action when a registered user add, edit or destroy an organisation

    Background:
      Given The DB have a lot of users
      And The database contains services

    Scenario: Validated user can create a organisation
      And I am logged in
      When I return to the site
      Then I see the create organisation button

    Scenario: Validated user create a organisation
      And I am logged in
      When I return to the site
      And I click on the Create an organisation link
      And I fill the organisation form
      And I click on the Create Organisation button
      Then I see a Organisation was successfully created. message