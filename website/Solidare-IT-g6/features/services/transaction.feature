Feature: All about transactions
  testing action when a registered user create a transaction

    Background:
      Given The database contains services

    Scenario: Validated user can create a feedback
      And I am logged in
      When I click on the Services link
      And I click on the Accept link
      And I click on the See my services link
      Then I should see a feedback link

#    Scenario: Validated user create a feedback
#      And I am logged in
#      When I click on the Services link
#      And I click on the Accept link
#      And I click on the See my services link
#      And I click on the Give a feedback ! link
#      And I give a feedback
#      Then I should not see a feedback link
