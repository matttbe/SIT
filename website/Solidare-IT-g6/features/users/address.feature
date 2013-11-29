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
      And I click on the New address link
      And I fill the address form
      And I click on the Add address button
      Then I see a Address was successfully created. message
      And I see my address

    Scenario: A registered user can not add a address with a not alpha number
      And I am logged in
      When I return to the site
      And I click on the Manage my addresses link
      And I click on the New address link
      And I fill the address form
      And I fill a wrong number
      And I click on the Add address button
      Then I see a Number is not a number message
      And I not see my address

    Scenario: A registered user can not add a address with a not alpha postal code
      And I am logged in
      When I return to the site
      And I click on the Manage my addresses link
      And I click on the New address link
      And I fill the address form
      And I fill a wrong postal code
      And I click on the Add address button
      Then I see a Postal code is not a number message
      And I not see my address
