##################################################################
#                  Licensing Information                         #
#                                                                #
#  The following code is licensed, as standalone code, under     #
#  the Ruby License, unless otherwise directed within the code.  #
#                                                                #
#  For information on the license of this code when distributed  #
#  with and used in conjunction with the other modules in the    #
#  Amp project, please see the root-level LICENSE file.          #
#                                                                #
#  © Michael J. Edgar and Ari Brown, 2009-2010                   #
#                                                                #
##################################################################

module Amp
  module Repositories
    
    ##
    # = CommonVersionedFileMethods
    #
    # These methods are common to all repositories, and this module is mixed into
    # the AbstractLocalRepository class. This guarantees that all repositories will
    # have these methods.
    #
    # No methods should be placed into this module unless it relies on methods in the
    # general API for repositories.
    module CommonChangesetMethods
      
      ##
      # A hash of the files that have been changed and their most recent diffs.
      # The diffs are lazily made upon access. To just get the files, use #altered_files
      # or #changed_files.keys
      # Checks whether this changeset included a given file or not.
      # 
      # @return [Hash{String => String}] a hash of {filename => the diff}
      def changed_files
        h = {}
        class << h
          def [](*args)
            super(*args).call # we expect a proc
          end
        end
        
        altered_files.inject(h) do |s, k|
          s[k] = proc do
            other = parents.first[k]
            other.unified_diff_with self[k]
          end
          s
        end
      end
      
      ##
      # Gets the number of lines added and removed in this changeset.
      #
      # @return [Hash{Symbol => Integer}] a hash returning line-changed
      #   statistics. Keys are :added, :deleted
      def changed_lines_statistics
        result = {:added => 0, :removed => 0}
        changed_files.each do |_, diffproc|
          diff = diffproc.call
          diff.split("\n").each do |line|
            if line.start_with?("+") && !line.start_with?("+++")
              result[:added] += 1
            elsif line.start_with?("-") && !line.start_with?("---")
              result[:removed] += 1
            end
          end
        end
        result
      end
      
      ##
      # Is +file+ being tracked at this point in time?
      # 
      # @param [String] file the file to lookup
      # @return [Boolean] whether the file is in this changeset's manifest
      def include?(file)
        all_files.include? file
      end
      
      ##
      # Gets the list of parents useful for printing in a template - no
      # point in saying that revision 127's only parent is 126, for example.
      #
      # @return [Array<Changeset>] a list of changesets that are the parent of
      #   this node and happen to be worth noting to the user.
      def useful_parents
        ret_parents = self.parents
        if ret_parents[1].nil?
          if ret_parents[0].revision >= self.revision - 1
            ret_parents = []
          else
            ret_parents = [ret_parents[0]]
          end
        end
        ret_parents
      end
      
      ##
      # Renders the changeset with a given template. Takes a few different options
      # to control output.
      #
      # @param [Hash] opts ({}) the options to control rendering to text
      # @option opts [Boolean] :no_output (false) Don't actually return any output
      # @option opts [String] :"template-raw" a bare string to render as a template.
      #   Nice option for letting users drop a teensy bit of template code into their
      #   commands.
      # @option opts [String, Template] :template ("default-log") The name of the
      #   template to use (if a String is provided), or the actual template to use
      #   (if a Template object is provided).
      # @return [String] the changeset pumped through the template.
      def to_templated_s(opts={})
        locals = {:change_node => node,
                  :revision    => self.revision,
                  :username    => self.user,
                  :date        => self.easy_date,
                  :files       => self.altered_files,
                  :description => self.description,
                  :branch      => self.branch,
                  :cs_tags     => self.tags,
        
                  :added       => opts[:added]   || [],
                  :removed     => opts[:removed] || [],
                  :updated     => opts[:updated] || [],
                  :config      => opts,

                  :parents     => useful_parents.map {|p| [p.revision, p.node.short_hex] }
                }
        
        return "" if opts[:no_output]
        
        template_for_options(opts).render(locals, binding)
      end
      
      ##
      # Returns template to handle templating based on the options provided.
      #
      # @param [Hash] options a list of options to configure template usage
      # @return [Template] a template to use to print the changeset to a
      #   nice string.
      def template_for_options(opts = {})
        type = opts[:template_type] || 'log'
        if opts[:"template-raw"]
          Support::RawERbTemplate.new(opts[:"template-raw"])
        elsif opts[:template].is_a?(Support::Template)
          opts[:template]
        else
          template = opts[:template]
          template = "default-#{type}" if template.nil? || template.to_s == "default"
          Support::Template['mercurial', template]
        end
      end
      
      ##
      # recursively walk
      # 
      # @param [Amp::Matcher] match this is a custom object that knows files
      #   magically. Not your grampa's proc!
      def walk(match)
        # just make it so the keys are there
        results = []
        
        hash = Hash.with_keys match.files
        hash.delete '.'
        
        each do |file|
          hash.each {|f, val| (hash.delete file and break) if f == file }
          
          results << file if match.call file # yield file if match.call file
        end
        
        hash.keys.sort.each do |file|
          if match.bad file, "No such file in revision #{revision}" and match[file]
            results << file # yield file
          end
        end
        results
      end
      
    end
  end
end
