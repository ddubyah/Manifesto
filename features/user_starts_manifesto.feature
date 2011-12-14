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
		
	Scenario: Make a manifest file with a template and one file collection
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
		
	Scenario: Make a manifest file with a template and multiple file collections
		Given an empty file named "empty.tmp"
		And an empty file named "pages/page1.html"
		And an empty file named "pages/page2.html"
		And an empty file named "pages/page3.html"
		And an empty file named "images/img1.jpg"
		And an empty file named "images/img2.jpg"
		And an empty file named "images/img3.jpg"
		When I run `manifesto --template empty.tmp --output_file duff.manifest 'pages/*.html' 'images/*.*'`
		Then the output should contain "Creating duff.manifest from empty.tmp with:"
		And the output should contain "pages/page1.html"
		And the output should contain "pages/page2.html"
		And the output should contain "pages/page3.html"
		And the output should contain "images/img1.jpg"
		
	Scenario: Render mustache template to the console
		Given a file named "simple.mustache" with:
		"""
		{{#file_groups}}
		Group: {{name}}
		{{/file_groups}}
		"""
		And an empty file named "pages/page1.html"
		And an empty file named "pages/page2.html"
		When I run `manifesto --template simple.mustache 'pages/*.html'`
		Then the output should contain "Group: pages/*.html"

	  
	
