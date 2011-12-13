#!/usr/bin/env ruby

require 'rubygems'
require 'commander/import'
require 'elf_manifesto'

program :version, ElfManifesto::VERSION
program :description, 'Creates file manifests from file collections and mustache templates'
 
command :create do |c|
  c.syntax = 'manifesto create [options]'
  c.summary = ''
  c.description = ''
  c.example 'description', 'command example'
  c.option '--some-switch', 'Some switch that does something'
  c.action do |args, options|
    # Do something or c.when_called Manifesto::Commands::Create
  end
end

