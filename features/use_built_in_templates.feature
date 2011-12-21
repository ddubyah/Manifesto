Feature: Using built-in Templates

  As a console user
  I want to use a range of built in templates
  So that I can create a range of manifests quickly

	Scenario: listing available templates
	  Given a library of templates: simple.mustache scorm.tmp simple.tmp example.tmp
		When I run `manifesto list templates`
		Then the output should contain "Available Templates:"
		And the output should contain "lib/templates" 
		And the output should contain "scorm.tmp"
		And the output should contain "simple.tmp"
		And the output should contain "example.tmp"
		
	Scenario: 'list' command alias
		Given a library of templates: simple.mustache scorm.tmp simple.tmp example.tmp
		When I run `manifesto list`
		Then the output should contain "Available Templates:"
		And the output should contain "lib/templates" 
		And the output should contain "scorm.tmp"
		And the output should contain "simple.tmp"
		And the output should contain "example.tmp"
		
	Scenario: showing the contents of a built in template
		Given a library of templates: test.tmp
		When I run `manifesto show template test`
		Then the output should contain "{{#groups}}"	
		
	Scenario: 'show' command alias
		Given a library of templates: test.tmp
		When I run `manifesto show test`
		Then the output should contain "{{#groups}}"
		
	Scenario: requesting the contents of a non-existent template
		Given a library of templates: test.tmp
		When I run `manifesto show template duffer`
		Then the exit status should not be 0
		And the output should contain "Template does not exist: duffer"
		
		
	Scenario: rendering with a built in template
		Given a library of templates: tester.mustache
		And a collection of files: page1.html page2.html page3.html
		When I run `manifesto --sample_template tester '**/*.html'`
		Then the output should contain "group1 (**/*.html):"
		And the output should contain "page1.html"
		And the output should contain "page2.html"
		And the output should contain "page3.html"
		And the exit status should be 0
		
	Scenario Outline: providing a bad sample template name
		Given a library of templates: tester.mustache
		When I run `<command>`
		Then the exit status should not be 0
		And the output should contain "<result>"
		
		Scenarios: Bad built in template selection
		| command                                | result                       | 
		| manifesto --sample_template duff '*.*' | Bad template selection: duff | 
		
		Scenarios: Bad template path
		| command                         | result                       | 
		| manifesto --template duff '*.*' | Bad template selection: duff | 
		
		
		

		
