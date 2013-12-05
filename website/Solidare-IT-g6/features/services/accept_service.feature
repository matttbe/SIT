Feature: Accept a Service
  testing action when a registered user accept a service

    Background:
      Given The DB have a lot of users
      And The database contains services

    Scenario: Validated user visiting a not own service can accept it
      And I am logged in
      When I visit the page of one service
      Then I should see the accept link 

    Scenario: Validated user visiting a not own service accept it
      And I am logged in
      When I visit the page of one service
      And I click on the Accept button
      Then I should see the service in my services espace 

    Scenario: Validated user accept a not own service
      And I am logged in
      When I visit the page of one service
      And I click on the Accept button
      Then I should see the service in my services espace 

    Scenario: Validated user can not accept a not own service that have already accepted
      And I am logged in
      When I visit the page of one service
      And I click on the Accept button
      And I visit the page of one service
      Then I should not see the accept link
 
