Given /^Manifesto is not yet running$/ do
  # pending # express the regexp above with the code you wish you had
	@result = ""
end

When /^I run "([^"]*)" at the command line$/ do |arg1|
  @result = `#{arg1}`
end

Then /^I should see "([^"]*)"$/ do |arg1|
  @result.should =~ "^#{arg1}"
end

