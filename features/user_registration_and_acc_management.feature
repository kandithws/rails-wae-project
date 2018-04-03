# https://github.com/cucumber/cucumber/wiki/Tags
@google_omniauth
Feature: UserRegistrationAndAccountManagement
  According to User Registration and Account Management UML workflow
  Scenario: Login
    Given I am user
    When I visit home page
    And I should see link for login
    When I click the link for login
    Then I should see form to login
    When I submit the credentials
    Then I should visit main project page

#  Scenario: Sign Up
#    Given I a new user with ait email
#    When I visit home page
#    Then I should see the link "Sign up"
#    When I click on the link "Sign up"
#    Then I should see the form to validate email
#    When I fill the form with my e-mail and submit
#    Then I should see the form to fill my additional information
#    And I should see my email already filled
#    When I fill the additional information and submit
#    Then I should visit main project page
#    And I should see "You have signed up successfully"

    Scenario: Sign Up Using Google AIT
    Given I a new user with ait email
    When I visit home page
    Then I should see the link "Sign Up using Google+ AIT"
    When I click on the link "Sign Up using Google+ AIT"
    Then I should see the form to fill my additional information
    And I should see my email already filled
    When I fill the additional information and submit
    Then I should visit main project page
    And I should see "You have signed up successfully"





