require 'mustache'

module ElfManifesto
  
  class ManifestMaker
    
    attr_reader :file_groups, :result
    
    # ManifestMaker Constructor
    #
    # * *Args*    :
    # options - +Hash+ -> Hash of options
    #   :template +String+ -> template file to load
    #   :properties +Hash+ -> arbitrary properties to supply to template
    #   :globs +Array+ -> list of file globs to evaluate
    def initialize(ops)
      @file_groups = get_file_groups(ops[:globs]) # evaluate the globs and create the file groups
      @file_groups[:props] = ops[:props] unless ops[:props].nil?
      template_file = File.open ops[:template], 'rb'
      @template = template_file.read
      @result = Mustache.render @template, @file_groups
      message = ""
      pos = 1
      # @file_groups.each do |name, group|
      #   message = "#{message}\nGroup #{pos} '#{name} (#{group[:path]})' -> [ #{group[:files].join(', ')} ]"
      #   pos+=1
      # end
      puts "#{message}\n\n\n"
      puts @result
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
 		  file_groups = { groups: [] }
 		  
      globs.each do |glob|
        # e.g { group1: { path: '*.*', files: [file1, file2]} }
        group_name = "group#{pos}"
        files = Dir.glob(glob)
        file_group_object = { name: group_name, path: glob, files: files }
        file_groups[group_name.to_sym] = file_group_object
        file_groups[:groups].push file_group_object
        pos += 1    
      end
      file_groups
 		end
 		
 
  end
end