module Gaku
  module Core
  	module TestingSupport
      module FlashHelpers

        def flash?(text)
          page.should have_selector("#notice", :text => text)
        end

        def flash_created?
          flash? 'successfully created'
        end

        def flash_updated?
          flash? 'successfully updated'
        end

        def flash_destroyed?
          flash? 'successfully destroyed'
        end

        def flash_recovered?
          flash? 'successfully recovered'
        end

        def flash_error_for(field)
          page.should have_selector("div.#{field}formError")
        end

      end
    end
  end
end
