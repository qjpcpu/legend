Feature: Create a story
  
  Scenario: Create an new story after login
    Given there are the following users:
	| email            | password         |
	| qjpcpu@gmail.com | qjpcpu@gmail.com |
	And I am signed in as them
    Given I am on the homepage
    Then I follow "Go Read Our Love Story"
    Then I should see "Please create your story first!"
    When I fill in "Title" with "qjp new love story"
    And I fill in "Instruction" with "this is instruction"
    And I attach the file "spec/fixtures/1.jpg" to "story_cover"
    And I press "Create Story"
    Then I should see "Story was successfully created."
