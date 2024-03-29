require 'spec_helper'
require "elf_manifesto/manifest_maker"
require 'mustache'

all_files = ['file1.txt', 'file2.', 'file3.txt', 'image1.jpg', 'image2.jpg']
image_files = ['image1.jpg', 'image2.jpg']
txt_files = ['file1.txt', 'file2.', 'file3.txt']
deep_files = ['path/image1.jpg', 'path/image2.jpg', 'path/to a/image.jpg']
deep_files_escaped = ['path/image1.jpg', 'path/image2.jpg', 'path/to%20a/image.jpg']

describe "Creating a manifest." do
	before(:each) do
	  
	end
	
  describe "Evaluating file groups." do
    it "should accept a single file group" do
      Dir.should_receive(:glob).with('*.*').and_return(all_files)
			mock_input_file_read "duff.template", simple_template()
			# manifesto = ElfManifesto::ManifestMaker.new('duff.template', {}, ['*.*'])
			ops = {
				template: 'duff.template',
				globs: ['*.*']
			}
			manifesto = ElfManifesto::ManifestMaker.new(ops)
    end

		describe "Gathering file collections." do
		  it "should evaluate a single glob string" do
		    Dir.should_receive(:glob).with('*.*').and_return(all_files)
				mock_input_file_read "duff.template", simple_template()
				ops = {
					template: 'duff.template',
					globs: ['*.*']
				}
				manifesto = ElfManifesto::ManifestMaker.new(ops)
				manifesto.file_groups[:group1][:files].should eq all_files
		  end
		
			it "should evaluate multiple glob strings" do
				Dir.should_receive(:glob).with('*.jpg').and_return(image_files)
				Dir.should_receive(:glob).with('*.*').and_return(all_files)
				Dir.should_receive(:glob).with('*.txt').and_return(txt_files)
				mock_input_file_read "duff.template", simple_template()
				
				ops = {
					template: 'duff.template',
					globs: ['*.*', '*.jpg', '*.txt']
				}
			  
				manifesto = ElfManifesto::ManifestMaker.new(ops)
				manifesto.file_groups[:group1][:files].should eq all_files
				manifesto.file_groups[:group2][:files].should eq image_files
				manifesto.file_groups[:group3][:files].should eq txt_files
			end
			
			it "should URI escape any paths" do
				Dir.should_receive(:glob).with('**/*.jpg').and_return(deep_files)
				mock_input_file_read "duff.template", simple_template()			  
				
				ops = {
					template: 'duff.template',
					globs: ['**/*.jpg']
				}
				
				manifesto = ElfManifesto::ManifestMaker.new(ops)
				manifesto.file_groups[:group1][:files].should eq deep_files_escaped
				manifesto.file_groups[:group1][:files_raw].should eq deep_files
			end
			
			describe "gathering information about the groups" do
				before(:each) do
				  Dir.should_receive(:glob).with('*.jpg').and_return(image_files)
					Dir.should_receive(:glob).with('*.*').and_return(all_files)
					Dir.should_receive(:glob).with('*.txt').and_return(txt_files)
					mock_input_file_read "duff.template", simple_template()

					ops = {
						template: 'duff.template',
						globs: ['*.*', '*.jpg', '*.txt']
					}
					@subject = ElfManifesto::ManifestMaker.new(ops)
				end
				
			  it "should store a list of the groups" do
					@subject.file_groups[:groups].should have(3).items
			  end
			end
			
			describe "Storing arbitrary properties" do
			  it "should make any property hashes provided available to the template" do
					Dir.should_receive(:glob).with('*.*').and_return(all_files)
					mock_input_file_read "duff.template", simple_template()
					ops = {
						template: 'duff.template',
						globs: ['*.*'],
						props: { name: 'foobar' }
					}
					manifesto = ElfManifesto::ManifestMaker.new(ops)
					manifesto.file_groups[:props][:name].should eq 'foobar'
			  end
			end
		end
		
		describe "Rendering the template" do
			before(:each) do
				# mock file expectations
				Dir.should_receive(:glob).with('*.jpg').and_return(image_files)
				Dir.should_receive(:glob).with('*.*').and_return(all_files)
				Dir.should_receive(:glob).with('*.txt').and_return(txt_files)
		  end
			
			it "should load a template" do
				mock_input_file_read "simple.mustache", simple_template()
				Mustache.stub(:render)	
				ops = {
					template: 'simple.mustache',
					globs: ['*.*', '*.jpg', '*.txt']
				}
				manifesto = ElfManifesto::ManifestMaker.new(ops)			  
			end
			
			describe "with Mustache" do
				before(:each) do
				 	mock_input_file_read "simple.mustache", simple_template()
					Mustache.should_receive(:render).and_return("The Result")
				end
				
				it "should use mustache to render the template" do
					ops = {
						template: 'simple.mustache',
						globs: ['*.*', '*.jpg', '*.txt']
					}
					manifesto = ElfManifesto::ManifestMaker.new(ops)
				end
				
				it "should store the result" do		
					ops = {
						template: 'simple.mustache',
						globs: ['*.*', '*.jpg', '*.txt']
					}
					manifesto = ElfManifesto::ManifestMaker.new(ops)
					manifesto.result.should eq 'The Result'
				end
			end
		
		end

  end
end

private 

def mock_input_file_read file_name, contents = ""
	# Set expectations
	@stuntfile = double()
	@stuntfile.should_receive(:read).and_return(contents)
	File.should_receive(:open).with(file_name,"rb").and_return(@stuntfile)
end

def simple_template
	<<-eos
	{{#.}}
	Files Matching {{path}}
		{{name}}
	{{/.}}
	eos
end


