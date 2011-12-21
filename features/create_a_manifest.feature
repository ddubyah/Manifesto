Feature: Create a Manifest

  As a User
  I want start manifesto from the command line
  So that I can create a manifest

	Scenario: Start manifesto with no parameters
		Given Manifesto is not yet running
		When I run `manifesto`
		Then the output should contain "Manifesto! throw me a frickin' bone here"
		And the output should contain "I need some parameters"
		And the output should contain "Use --help to find out how"
		
	Scenario Outline: render a simple template with a single glob to the console
		Given a file named "simple.mustache" with:
		"""
		Group1: ({{group1.path}})
		{{#group1.files}}
		{{.}}
		{{/group1.files}}
		"""
		And some empty files file1.txt file2.jpg file3.jpg file4.png
		When I run `manifesto --template simple.mustache <globs>`
		Then the output should contain "<results>"
		
		Scenarios: Single globs 
		| globs   | results          | 
		| '*.*'   | file1.txt\nfile2 | 
		| '*.*'   | Group1: (*.*)    | 
		| '*.png' | file4            | 
		| '*.jpg' | file2.jpg        | 
		| '*.jpg' | file3.jpg        | 
		
	Scenario Outline: render a simple template with multiple globs to the console
		Given a file named "simple.mustache" with:
		"""
		Matched Groups:
		{{#groups}}
		{{name}} ({{path}}): {{#files}}{{.}} {{/files}}
		{{/groups}}
		"""
		And some empty files file1.txt file2.jpg file3.jpg file4.png
		When I run `manifesto --template simple.mustache <globs>`
		Then the output should contain "<results>"
		
		Scenarios: single globs
		| globs   | results         | 
		| '*.*'   | file1.txt file2 | 
		| '*.*'   | group1 (*.*)    | 
		| '*.png' | file4           | 
		| '*.png' | (*.png)         | 
		| '*.jpg' | file2.jpg       | 
		| '*.jpg' | file3.jpg       | 
		
		Scenarios: multiple globs
		| globs         | results   | 
		| '*.*' '*.png' | group1    | 
		| '*.*' '*.png' | group2    | 
		| '*.*' '*.png' | file1.txt | 
		| '*.*' '*.png' | file4.png | 
		
	Scenario: render arbitrary properties
		Given a file named "simple.mustache" with:
		"""
		Group ID: {{props}}
		{{#groups}}
		{{name}} ({{path}}): {{#files}}{{.}} {{/files}}
		{{/groups}}
		"""
		And some empty files file1.txt file2.jpg file3.jpg file4.png
		When I run `manifesto -m simple.mustache --properties "{ group_id: '1234' }" '*.*'`
		Then the output should contain "1234"
		
		

