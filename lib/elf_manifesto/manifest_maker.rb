module ElfManifesto
  
  class ManifestMaker
    
    attr_reader :file_groups
    
    # ManifestMaker Constructor
    #
    # * *Args*    :
    # template - +String+ -> path to manifest template
    def initialize(template, target, globs)
      @file_groups = get_file_groups(globs)
      message = "Creating #{target} from #{template} with:"
      pos = 1
      @file_groups.each do |key, group|
        message = "#{message}\nGroup #{pos} '#{key}' -> [ #{group.join(', ')} ]"
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
			file_groups = {}
 			globs.each do |glob|
 				file_groups[glob] = Dir.glob(glob)
 			end
 			file_groups
 		end
    
    
    
  end
end