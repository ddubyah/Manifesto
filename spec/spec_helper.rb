require 'simplecov'
SimpleCov.start do
	add_group "CLI", "bin"
	add_group "Workers", "lib/elf_manifesto"
end