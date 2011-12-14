module ElfManifesto
  
  class ManifestMaker
    
    attr_reader :file_groups, :result
    
    # ManifestMaker Constructor
    #
    # * *Args*    :
    # template - +String+ -> path to manifest template
    def initialize(template, globs)
      @file_groups = get_file_groups(globs)
      template_file = File.open template, 'rb'
      @template = template_file.read
      @result = Mustache.render @template, @file_groups
      message = ""
      pos = 1
      @file_groups.each do |name, group|
        message = "#{message}\nGroup #{pos} '#{name} (#{group[:path]})' -> [ #{group[:files].join(', ')} ]"
        pos+=1
      end
      puts "#{message}\n"
    end

		private
 		# get_file_groups
 		#
 		# * *Args*    :
 		#  globs - +Array+ -> list of strings to use as file searches
 		# * *Returns* :
 		#   - dictionary of file group arrays
 		def get_file_groups globs
 		  pos = 1
 		  groups = {}
      globs.each do |glob|
       groups["group#{pos}".to_sym] = { path: glob, files: Dir.glob(glob) }  
       pos += 1    
      end
      groups
 		end
 		
 
  end
end