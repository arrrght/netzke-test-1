Feature: Check login window
In order to value
As a role
I want feature

@javascript
Scenario: Check window properties (and button Enter should be disabled by default)
	Given I am on the login page
	Then I should see "Login window"
	And I should see "User"
	And I should see "Password"
	Then button "Enter" should be disabled
	When I fill in "username" with "some"
	And I fill in "password" with "somepass"
	And I sleep 1 seconds
	Then button "Enter" should be enabled

@javascript
Scenario: Check login
	Given I have a user named "user1" with password "pass1"
	And I am on the login page
	When I fill in "username" with "wrong_user"
	And I fill in "password" with "wrong_password"
	And I press "Enter"
	When I wait for the response from the server
	And I sleep 1 seconds
	Then I should see "Wrong!"
	When I fill in "username" with "user1"
	And I fill in "password" with "pass1"
	And I press "Enter"
	When I wait for the response from the server
	And I sleep 1 seconds
	Then I should see "Hello, user1!"
