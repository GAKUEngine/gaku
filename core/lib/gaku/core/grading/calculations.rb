module Gaku
  module Core
    module Grading
    	module Calculations

    		def self.included(base)
          base.send(:include, InstanceMethods)
          base.extend(ClassMethods)
        end

        module ClassMethods      
         	# will use this methods in controller
          def test
            "testin"
          end
        end

        module InstanceMethods
        end
    	end
    end
  end
end