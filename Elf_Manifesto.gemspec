# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "elf_manifesto/version"

Gem::Specification.new do |s|
  s.name        = "elf_manifesto"
  s.version     = ElfManifesto::VERSION
  s.authors     = ["Darren Wallace"]
  s.email       = ["wallace@midweekcrisis.com"]
  s.homepage    = ""
  s.summary     = %q{Creates file manifests from provided templates}
  s.description = %q{Primarily used for creating SCORM manifests. Uses mustache templates and file info to create manifests. Intended for use from the command line or on the build server.}

  s.rubyforge_project = "ELF_Manifesto"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"

	s.add_development_dependency "rake", "~> 0.9.2.2"
  s.add_development_dependency "bundler", "~> 1.0.21"
  s.add_development_dependency "rspec", "~> 2.7.0"  
  s.add_development_dependency "cucumber", "~> 1.1.4"
  s.add_development_dependency "guard-cucumber", "~> 0.7.4"
  s.add_development_dependency "aruba", "~> 0.4.11"
  s.add_development_dependency 'simplecov', '>= 0.4.0'

	if RUBY_PLATFORM.downcase.include?("darwin")		
		s.add_development_dependency "guard-rspec"  
	  s.add_development_dependency "growl"
	  s.add_development_dependency "rb-fsevent"
	end
	
	s.add_runtime_dependency "commander", "~> 4.0.6"
	s.add_runtime_dependency "mustache", "~> 0.99.4"
	

end
