Feature: Using a config file with manifesto

  As a manifesto user
  I want to provide a config file
  So that I can re-use a set of config options and I don't need to write horribly long commands in the terminal

	Scenario: Using a config file to run a built in template
	  Given a file named "manifesto.config" with:
		"""
		{
			template: "_simple",
			globs: ["learning_objects/**/*.html", "assets*/**/*.* ", "js/**/*.*"],
			props: {
				manifest_id:'com.hmeelearning.eh',
				org_id: 'hmeeh',sco_id: 'ID72c02ada-df91-41ca-a440-15062a4683c0',
				org_name: 'Experience Hyundai',
				sco_name: 'Module 6 - Quiz',
				sco_pass_score: 0.7
			}
		}
		"""
		And a library of templates: simple.mustache
	  When I run `manifesto -c manifesto.config '*.*'`
	  Then the output should contain "group1"
		And the output should contain "sco_name"
		And the output should contain "Module 6"
	
	
	

  
