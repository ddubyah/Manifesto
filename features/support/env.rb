require 'aruba/cucumber'

# Add the bin directory to aruba's executable path
ENV['PATH'] = "#{File.expand_path(File.dirname(__FILE__) + '/../../bin')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"