require "bundler/gem_tasks"
require 'cucumber/rake/task'
require 'rspec/core/rake_task'

desc "Does stuff"
Cucumber::Rake::Task.new(:tester) do |t|
	
end

desc "Run specs"
RSpec::Core::RakeTask.new do |t|
  t.pattern = "./spec/**/*_spec.rb" # don't need this, it's default.
  # Put spec opts in a file named .rspec in root
end

desc "Run specs and features"
task :default => [:tester, :spec, :build] do
end

