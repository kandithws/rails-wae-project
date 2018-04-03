Feature: current user functionalities

  Background:

    Given I am user
    And I'm signed in

  Scenario: view and edit profile
    Given i should see 'Profile' button
    When i click on 'Profile' button
    Then i should see my profile details
    And i click on edit profile
    And i see fields filled with my details
    And i update my cell_phone_no
    When i click on update user
    Then i should see my updated profile


  Scenario: search by category
    Given i should see drop down to search category
    When i Click on it
    Then i see the categories to select
    When i click on the category 'gadgets'
    Then i see 'gadget' posts

#  Scenario: Search by product name
#
#    Given i should see search bar
#    And i fill in with product_name
#    When i click on search button
#    Then i should see the posts of product_name
#
#  Scenario: view post owner profile
#    Given There few posts on the main page
#    And i click on username of a post
#    Then i should see owner profile details




#Given I am user
#    And I'm signed in
#
#    Scenario:
#    Given i should see Profile button
#    When i click on it
#    Then i should see my profile details
#    And my posted items
