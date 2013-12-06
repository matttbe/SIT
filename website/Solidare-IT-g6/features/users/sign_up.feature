Feature: Sign up
  In order to get access to protected sections of the site
  As a user
  I want to be able to sign up

    Background:
      Given I am not logged in

    Scenario: User signs up with valid data
      When I sign up with valid user data
      Then I see a You received an email from us. Please activate your account message
      
    Scenario: User signs up with invalid email
      When I sign up with an invalid email
      Then I see a Email is invalid message

    Scenario: User signs up without password
      When I sign up without a password
      Then I should see a missing Password message

    Scenario: User signs up without password confirmation
      When I sign up without a password confirmation
      #we use msg and not the generic because we have here a special message for blank filling
      Then I should see a missing password confirmation msg

    Scenario: User signs up with mismatched password and confirmation
      When I sign up with a mismatched password confirmation
      Then I see a Password confirmation doesn't match Password message
