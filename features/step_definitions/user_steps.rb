Given /^I am signed in as them$/ do
	steps(%Q{
		Given I am on the homepage
	    When I follow "Login"
	    And I fill in "Email" with "#{@user.email}"
	    And I fill in "Password" with "#{@user.email}"
	    And I press "Sign in"
	    Then I should see "Signed in successfully."
	})
end