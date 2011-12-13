Feature: User Starts Manifesto

  As a User
  I want start manifesto from the command line
  So that I can create a manifest

	Scenario: Start manifesto with no parameters
		Given Manifesto is not yet running
		When I run `manifesto`
		Then the output should contain "Bummer"

	  
	
