require 'mustache'
require 'uri'

module ElfManifesto
  
  class ManifestMaker
    
    attr_reader :file_groups, :result 
    # *Args*
    # * ops:: +Hash+ -> Hash of options
		# 	
		# 		ops = { 
		# 			template: 'path/to/template.file',
		# 			properties: { prop1: 'foobar' },
		# 			globs: ['*.*', '*.jpg'], 	
		# 		}
		#
		# 		ElfManifesto::ManifestMaker.new(ops)
		# 	
    # 	[+template+] +String+ -> template file to load
    # 	[+properties+] +Hash+ -> arbitrary properties to supply to template
    # 	[+globs+] +Array+ -> list of file globs to evaluate
    def initialize(ops)
      @file_groups = get_file_groups(ops[:globs]) # evaluate the globs and create the file groups
      @file_groups[:props] = ops[:props] unless ops[:props].nil?
      template_file = File.open ops[:template], 'rb'
      @template = template_file.read
      @result = Mustache.render @template, @file_groups
      message = ""
      pos = 1
      # puts "#{message}\n\n\n"
      puts @result
    end

		private
 		# get_file_groups
		# Evaluate the globs array and populate the file_groups object.
		# It's the file_groups object that is used to populate the template.
 		#
 		# * *Args*    :
 		#  globs - +Array+ -> list of strings to use as file searches
 		# * *Returns* :
 		#   - dictionary of file group arrays
 		def get_file_groups globs
 		  pos = 1
 		  file_groups = { groups: [] }
 		  
      globs.each do |glob|
        # e.g { group1: { path: '*.*', files: [file1, file2]} }
        group_name = "group#{pos}"
        files_raw = Dir.glob(glob)
				files = files_raw.map do |f|
	      	URI.escape f
        end
        file_group_object = { name: group_name, path: glob, files: files , files_raw: files_raw}
        file_groups[group_name.to_sym] = file_group_object
        file_groups[:groups].push file_group_object
        pos += 1    
      end
      file_groups
 		end
 		
 
  end
end