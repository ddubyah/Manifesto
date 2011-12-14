Feature: User Starts Manifesto

  As a User
  I want start manifesto from the command line
  So that I can create a manifest

	Scenario: Start manifesto with no parameters
		Given Manifesto is not yet running
		When I run `manifesto`
		Then the output should contain "Manifesto! throw me a frickin' bone here"
		And the output should contain "I need some parameters"
		And the output should contain "Use --help to find out how"
		
	Scenario: Simple manifest with one file collection
		Given a file named "duff.template" with:
		"""
		this is a template
		"""
		And an empty file named "pages/page1.html"
		And an empty file named "pages/page2.html"
		When I run `manifesto --template duff.template --output_file manifest.txt 'pages/*.html'`
		Then the output should contain "Creating manifest.txt from duff.template with:"
		And the output should contain "pages/page1.html"
		And the output should contain "pages/page2.html"
		

	  
	
