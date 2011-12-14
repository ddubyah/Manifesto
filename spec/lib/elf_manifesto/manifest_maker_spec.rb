require "elf_manifesto/manifest_maker"

all_files = ['file1.txt', 'file2.', 'file3.txt', 'image1.jpg', 'image2.jpg']
image_files = ['image1.jpg', 'image2.jpg']
txt_files = ['file1.txt', 'file2.', 'file3.txt']

describe "Creating a manifest" do
	before(:each) do
	  
	end
	
  describe "With a valid template and output target" do
    it "should accept a single file group" do
      Dir.should_receive(:glob).with('*.*').and_return(all_files)
			manifesto = ElfManifesto::ManifestMaker.new('duff.template', 'duff.manifest', ['*.*'])
    end

		describe "Gathering file collections" do
		  it "should evaluate a single glob string" do
		    Dir.should_receive(:glob).with('*.*').and_return(all_files)
		
				manifesto = ElfManifesto::ManifestMaker.new('duff.template', 'duff.manifest', ['*.*'])
				manifesto.file_groups['*.*'].should eq all_files
		  end
		
			it "should evaluate multiple glob strings" do
				Dir.should_receive(:glob).with('*.jpg').and_return(image_files)
				Dir.should_receive(:glob).with('*.*').and_return(all_files)
				Dir.should_receive(:glob).with('*.txt').and_return(txt_files)
			  
				manifesto = ElfManifesto::ManifestMaker.new('duff.template', 'duff.manifest', ['*.*', '*.jpg', '*.txt'])
				manifesto.file_groups['*.jpg'].should eq image_files
			end
		end
		
		describe "Console output" do
			before(:each) do
				# mock file expectations
				Dir.should_receive(:glob).with('*.jpg').and_return(image_files)
				Dir.should_receive(:glob).with('*.*').and_return(all_files)
				Dir.should_receive(:glob).with('*.txt').and_return(txt_files)
		  end
		
		  it "should explain the current action" do
				STDOUT.should_receive(:puts).with(/^Creating duff.manifest from duff.template with:\n/)
				manifesto = ElfManifesto::ManifestMaker.new('duff.template', 'duff.manifest', ['*.*', '*.jpg', '*.txt'])		    
		  end
		end

  end
end

private 

