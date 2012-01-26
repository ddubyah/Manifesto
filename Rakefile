require "bundler/gem_tasks"
require 'cucumber/rake/task'
require 'rspec/core/rake_task'

desc "Runs the Cucumber features"
Cucumber::Rake::Task.new(:cuke) do |t|
	
end

desc "Run Rspec specs"
RSpec::Core::RakeTask.new do |t|
  t.pattern = "./spec/**/*_spec.rb" # don't need this, it's default.
  # Put spec opts in a file named .rspec in root
end

desc "Make sure the bin/manifesto file is executable"
task :make_executable do
	target = File.expand_path("bin/manifesto", File.dirname(__FILE__))
	puts "Making target executable #{target}"
	chmod 0755, target 
end

desc "Run all tests"
task :testing => [:cuke, :spec]

desc "Run specs and features, then build"
task :default => [:testing, :build] do
end

desc "Full setup, test then build"
task :full => [:make_executable, :default]


