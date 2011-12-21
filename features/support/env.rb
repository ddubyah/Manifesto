require 'simplecov'

SimpleCov.start do
	add_group "CLI", "bin/manifesto"
	add_group "Workers", "lib/elf_manifesto"
	add_filter "/features/"
end

require 'aruba/cucumber'
require 'cucumber/rspec/doubles'

# Add the bin directory to aruba's executable path
ENV['PATH'] = "#{File.expand_path(File.dirname(__FILE__) + '/../../bin')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"