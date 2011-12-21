require 'rspec'
Given /^a library of templates: (.+)$/ do |files|
	# TODO: Currently unable to mock the file system from Cucumber. So relying on contents of template folder
	# => 	Need to mock the FS to reduce fragility in the tests.
	template_files = files.split(' ')
	relative_path_to_templates = File.join('..','..','lib','templates')
	path_to_templates = File.expand_path(relative_path_to_templates, File.dirname(__FILE__) )
	# puts "Template path: #{path_to_templates}"
	Dir.chdir path_to_templates
	template_files.each do |filename|
		steps %Q{
			Given a file named "#{filename}" with:
			"""
			Matched Groups:
			{{#groups}}
			{{name}} ({{path}}): {{#files}}{{.}} {{/files}}
			{{/groups}}

			Each file glob passed in creates a new file group. Each group has a name, path and files property. Reference specific file groups by their name which is 'group' followed by the group number. So 'group1' for the first group etc.

			So the first group's path glob is -> {{group1.path}}
			And the files matching it are:
			{{#group1.files}}
				{{.}}
			{{/group1.files}}

			{{#props}}Properties{{/props}}
			{{props}}
			"""
		}
	end
end

Given /^a collection of files: (.+)$/ do |files|
	file_list = files.split " "
	file_list.each do |file|
		steps %Q{
			Given an empty file named "#{file}"
		}
	end
end

