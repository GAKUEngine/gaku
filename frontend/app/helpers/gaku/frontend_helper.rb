module Gaku
  module FrontendHelper

    include Gaku::AutocompleteHelper
    include Gaku::ExamHelper
    include Gaku::FlashHelper
    include Gaku::PersonHelper
    include Gaku::SharedHelper
    include Gaku::StudentChooserHelper
    include Gaku::StudentsHelper

    def prepare_target(nested_resource, address)
      return nil if nested_resource.blank?
      [nested_resource, address].flatten
    end


    def prepare_resource_name(nested_resources, resource)
      @resource_name = [nested_resources.map {|r| r.is_a?(Symbol) ? r.to_s : get_class(r) }, resource.to_s].flatten.join '-'
    end

    def extract_grouped(grouped, resource)
      grouped.map(&resource.to_sym)
    end


  end
end