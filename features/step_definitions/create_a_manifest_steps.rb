Given /^Manifesto is not yet running$/ do
  # pending # express the regexp above with the code you wish you had
	puts "Environment Path is: #{ENV['PATH']}"
end

Given /^some empty files(\s.+)$/ do |arg|
  files = arg.strip.split" "
	files.each do |file|
		steps %Q{
			Given an empty file named "#{file}"
		}
	end
end

