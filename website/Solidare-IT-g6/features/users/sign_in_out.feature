Feature: User
  everything about user

    Scenario: User is not signed up
      Given I do not exist as a user
      When I sign in with valid credentials
      Then I see a Invalid email or password message
        And I should be signed out

    Scenario: User signs in successfully
      Given I exist as a user
        And I am not logged in
      When I sign in with valid credentials
      Then I see a Signed in successfully message
      When I return to the site
      Then I should be signed in

    Scenario: User enters wrong email
      Given I exist as a user
      And I am not logged in
      When I sign in with a wrong email
      Then I see a Invalid email or password message
      And I should be signed out
      
    Scenario: User enters wrong password
      Given I exist as a user
      And I am not logged in
      When I sign in with a wrong password
      Then I see a Invalid email or password message
      And I should be signed out

    Scenario: User signs out
      Given I am logged in
      When I sign out
      Then I see a Signed out successfully message
      When I return to the site
      Then I should be signed out

    Scenario: a non validated user can't log in
      Given I exist as a non validated user
        And I am not logged in
      When I sign in with valid credentials
      Then I see a An admin must first accept you. Please be patient! message
      When I return to the site
      Then I should be signed out
