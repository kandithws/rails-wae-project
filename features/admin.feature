Feature: admin
  Background:
    Given I am an admin
    And There are some users in the system
    And I'm signed in as admin
#    Then i should see list of recently registered users


  Scenario: admin can see registered users
    When I click on the link "Admin Dashboard"
    And  I click on users tab on the navigation bar
    Then I should see list of recently registered users
    When Another user has just create an account
    And I refresh the page and click to sort on "Remember created at"
    Then I should see that new user added to the list on the top

  Scenario: admin can ban user
    Given I want to ban "user3"
    When I click on the link "Admin Dashboard"
    And  I click on users tab on the navigation bar
    Then I should see list of recently registered users
    When I click on that "user3"'s "Edit" icon
    Then I should see a banned tick box
    When I click on the banned tick box and saved
    And I logged out
    And I login as "user3"
    Then I should see "This account has been suspended for violation"

  Scenario: admin can see statistics of a user
    # We do logout and login because we want to update user statistics before we validating ut
    Given I sign out
    And I login as "user2"
    And I sign out
    And I login as "admin"
    And I click on the link "Admin Dashboard"
    And I click on users tab on the navigation bar
    When I click on that "user2"'s "History" icon
    Then I should see History record of this user





