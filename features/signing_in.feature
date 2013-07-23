Feature: Signing in
  In order to user the site
  As a user
  I want to be able to sign in

  Scenario: Signing in
    Given there are the following users:
      | email            | password         |
      | qjpcpu@gmail.com | qjpcpu@gmail.com |
    And I am on the homepage
    When I follow "Login"
    And I fill in "Email" with "qjpcpu@gmail.com"
    And I fill in "Password" with "qjpcpu@gmail.com"
    And I press "Sign in"
    Then I should see "Signed in successfully."